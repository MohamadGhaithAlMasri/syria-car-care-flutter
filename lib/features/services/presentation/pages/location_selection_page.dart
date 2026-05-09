import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:geolocator/geolocator.dart';
import 'package:syria_car_care2/features/account/domain/entities/user_address.dart';
import 'package:syria_car_care2/features/account/presentation/bloc/account_bloc.dart';
import '../../../../core/services/map_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:syria_car_care2/features/services/presentation/pages/service_menu_page.dart';

class LocationSelectionScreen extends StatefulWidget {
  final String vehicleId;
  const LocationSelectionScreen({super.key, required this.vehicleId});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final MapController _mapController = MapController();
  LatLng _center = const LatLng(33.5138, 36.2765);

  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isSearching = false;

  final DraggableScrollableController _draggableController =
      DraggableScrollableController();
  double _sheetSize = 0.4;

  @override
  void initState() {
    super.initState();
    _draggableController.addListener(() {
      setState(() {
        _sheetSize = _draggableController.size;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _draggableController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _center = LatLng(position.latitude, position.longitude);
      _mapController.move(_center, 15);
    });
  }

  Future<void> _searchLocations(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isSearching = true);

    try {
      final results = await MapService.searchLocations(query);
      setState(() => _searchResults = results);
    } catch (e) {
      debugPrint('Error searching: $e');
    } finally {
      setState(() => _isSearching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final fabBottom = (screenHeight * _sheetSize) + 10;

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 13,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture) {
                  _center = position.center!;
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.syria_car_care',
              ),
            ],
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Icon(
                Icons.location_on,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                size: 45,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 70,
            right: 20,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (_isSearching)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      else
                        const Icon(Icons.search, color: Colors.grey),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          onSubmitted: _searchLocations,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: 'search_car_location'.tr(),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_searchResults.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final result = _searchResults[index];
                        return ListTile(
                          title: Text(
                            result['display_name'],
                            textAlign: TextAlign.right,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                          onTap: () {
                            final lat = double.parse(result['lat']);
                            final lon = double.parse(result['lon']);
                            setState(() {
                              _center = LatLng(lat, lon);
                              _mapController.move(_center, 15);
                              _searchResults = [];
                              _searchController.text =
                                  result['name'] ??
                                  result['display_name'].split(',').first;
                              FocusScope.of(context).unfocus();
                            });
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: fabBottom,
            right: 20,
            child: FloatingActionButton(
              heroTag: 'my_location',
              onPressed: _getCurrentLocation,
              backgroundColor: Theme.of(context).cardColor,
              child: Icon(
                Icons.my_location,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
          DraggableScrollableSheet(
            controller: _draggableController,
            initialChildSize: 0.435,
            minChildSize: 0.15,
            maxChildSize: 0.44,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.transparent
                          : Colors.black12,
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(25),
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ),
                    Text(
                      "Saved locations",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 15),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        final List<UserAddress> addresses =
                            state is AccountLoaded ? state.addresses : [];

                        final home = addresses.cast<UserAddress?>().firstWhere(
                          (a) => a?.type == 'home',
                          orElse: () => null,
                        );
                        final work = addresses.cast<UserAddress?>().firstWhere(
                          (a) => a?.type == 'work',
                          orElse: () => null,
                        );
                        final parents = addresses
                            .cast<UserAddress?>()
                            .firstWhere(
                              (a) => a?.type == 'parents',
                              orElse: () => null,
                            );

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSavedLocation(
                              "home_loc".tr(),
                              Icons.home,
                              context,
                              home,
                            ),
                            _buildSavedLocation(
                              "work_loc".tr(),
                              Icons.work,
                              context,
                              work,
                            ),
                            _buildSavedLocation(
                              "parents_loc".tr(),
                              Icons.people,
                              context,
                              parents,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'تفاصيل إضافية',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        decoration: InputDecoration(
                          hintText: 'location_hint'.tr(),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).textTheme.bodySmall?.color?.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceMenuScreen(
                                vehicleId: widget.vehicleId,
                                latitude: _center.latitude,
                                longitude: _center.longitude,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B3B5A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.cyanAccent,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'confirm_location'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSavedLocation(
    String label,
    IconData icon,
    BuildContext context,
    UserAddress? address,
  ) {
    final bool isSet = address != null;

    return GestureDetector(
      onTap: () {
        if (isSet) {
          setState(() {
            _center = LatLng(address.latitude, address.longitude);
            _mapController.move(_center, 15);
            _searchController.text = address.addressName;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('address_not_set_msg'.tr(args: [label]))),
          );
        }
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: isSet
              ? Border.all(color: Colors.cyan.withOpacity(0.5), width: 1)
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSet
                  ? Colors.cyan
                  : Theme.of(
                      context,
                    ).textTheme.bodyLarge?.color?.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSet ? FontWeight.bold : FontWeight.w500,
                color: isSet
                    ? Colors.cyan
                    : Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/services/map_service.dart';
import '../../domain/entities/user_address.dart';
import '../bloc/account_bloc.dart';

class AddressPickerScreen extends StatefulWidget {
  final String type;
  final UserAddress? initialAddress;

  const AddressPickerScreen({
    super.key,
    required this.type,
    this.initialAddress,
  });

  @override
  State<AddressPickerScreen> createState() => _AddressPickerScreenState();
}

class _AddressPickerScreenState extends State<AddressPickerScreen> {
  final MapController _mapController = MapController();
  LatLng _center = const LatLng(33.5138, 36.2765);
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialAddress != null) {
      _center = LatLng(widget.initialAddress!.latitude, widget.initialAddress!.longitude);
      _searchController.text = widget.initialAddress!.addressName;
    } else {
      _getCurrentLocation();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        _mapController.move(_center, 15);
      });
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
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
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15,
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
                color: Theme.of(context).primaryColor,
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
                icon: const Icon(Icons.arrow_back),
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
                          onSubmitted: _searchLocations,
                          decoration: InputDecoration(
                            hintText: 'search_car_location'.tr(),
                            border: InputBorder.none,
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
                    ),
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final result = _searchResults[index];
                        return ListTile(
                          title: Text(result['display_name']),
                          onTap: () {
                            final lat = double.parse(result['lat']);
                            final lon = double.parse(result['lon']);
                            setState(() {
                              _center = LatLng(lat, lon);
                              _mapController.move(_center, 15);
                              _searchResults = [];
                              _searchController.text = result['display_name'];
                            });
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'save_as'.tr(args: [widget.type.tr()]),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        final address = UserAddress(
                          id: widget.initialAddress?.id ?? const Uuid().v4(),
                          userId: '', // Will be set in datasource
                          type: widget.type,
                          latitude: _center.latitude,
                          longitude: _center.longitude,
                          addressName: _searchController.text.isNotEmpty 
                              ? _searchController.text 
                              : 'Location at ${_center.latitude.toStringAsFixed(4)}, ${_center.longitude.toStringAsFixed(4)}',
                        );
                        context.read<AccountBloc>().add(SaveAddressEvent(address));
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B3B5A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text('save'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

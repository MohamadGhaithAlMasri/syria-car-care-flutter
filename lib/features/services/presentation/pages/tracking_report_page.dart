import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/services/map_service.dart';
import '../../domain/entities/booking.dart';

class LiveTrackingScreen extends StatefulWidget {
  final Booking? booking;
  const LiveTrackingScreen({super.key, this.booking});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  List<LatLng> _routePoints = [];
  final LatLng _startPoint = const LatLng(33.5138, 36.2765); // ساحة الأمويين
  late LatLng _endPoint;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _endPoint = LatLng(
      widget.booking?.latitude ?? 33.5100,
      widget.booking?.longitude ?? 36.2700,
    );
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    final points = await MapService.getRoute(_startPoint, _endPoint);
    if (mounted) {
      setState(() {
        _routePoints = points;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Background
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                  (_startPoint.latitude + _endPoint.latitude) / 2,
                  (_startPoint.longitude + _endPoint.longitude) / 2,
                ),
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.syria_car_care',
                ),
                if (_routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _routePoints,
                        color: Colors.cyan,
                        strokeWidth: 5,
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: [
                    // Start Point (Umayyad Square)
                    Marker(
                      point: _startPoint,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 35,
                      ),
                    ),
                    // End Point (User Location)
                    Marker(
                      point: _endPoint,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.local_car_wash,
                        color: Colors.cyan,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Header
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                    Text(
                      'تتبع مباشر',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'LIVE TRACKING',
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.cyanAccent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (!_isLoading)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PM 14:25',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'الوصول المتوقع',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      Container(
                        width: 150,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Sheet Information
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(35),
                ),
                boxShadow: [
                   BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatusStep(
                        context,
                        "اكتمل",
                        Icons.verified_outlined,
                        false,
                      ),
                      _buildStatusStep(
                        context,
                        "بدأ الغسيل",
                        Icons.water_drop_outlined,
                        false,
                      ),
                      _buildStatusStep(
                        context,
                        "في الطريق",
                        Icons.local_shipping,
                        true,
                      ),
                      _buildStatusStep(
                        context,
                        "تم الحجز",
                        Icons.check_circle,
                        true,
                        isDone: true,
                      ),
                    ],
                  ),
                  const Divider(height: 40),

                  Row(
                    children: [
                      _buildActionBtn(
                        Icons.phone,
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Theme.of(context).textTheme.bodyLarge?.color ??
                            Colors.black,
                      ),
                      const SizedBox(width: 10),
                      _buildActionBtn(
                        Icons.chat_bubble_outline,
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Theme.of(context).textTheme.bodyLarge?.color ??
                            Colors.black,
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'أحمد',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                          const Text(
                            'محترف العناية',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Row(
                            children: [
                              Text(
                                '4.8',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/100',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [
                      _buildDetailBox(
                        context,
                        "رقم الطلب",
                        widget.booking?.id.substring(0, 8).toUpperCase() ?? "SC-TEMP",
                      ),
                      const SizedBox(width: 15),
                      _buildDetailBox(
                        context,
                        "الخدمة المطلوبة",
                        "غسيل VIP كامل",
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'العودة للرئيسية',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  Widget _buildStatusStep(
    BuildContext context,
    String title,
    IconData icon,
    bool isActive, {
    bool isDone = false,
  }) {
    Color color = isDone
        ? Colors.cyan
        : (isActive
              ? (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black)
              : Colors.grey.shade500);
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildActionBtn(IconData icon, Color bg, Color iconCol) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, color: iconCol),
    );
  }

  Widget _buildDetailBox(BuildContext context, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


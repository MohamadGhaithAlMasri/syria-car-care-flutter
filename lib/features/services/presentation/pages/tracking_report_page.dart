import 'package:flutter/material.dart';

import '../../domain/entities/booking.dart';

class LiveTrackingScreen extends StatelessWidget {
  final Booking? booking;
  const LiveTrackingScreen({super.key, this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: Stack(
        children: [

          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.stack.imgur.com/HILX3.png',
                ),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
          ),

          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xFF102A43),
                      ),
                    ),
                    const Text(
                      'تتبع مباشر',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF102A43),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
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

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF102A43),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_shipping,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF102A43),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'يصل خلال ٧ دقائق',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatusStep("اكتمل", Icons.verified_outlined, false),
                      _buildStatusStep(
                        "بدأ الغسيل",
                        Icons.water_drop_outlined,
                        false,
                      ),
                      _buildStatusStep("في الطريق", Icons.local_shipping, true),
                      _buildStatusStep(
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
                        Colors.blueGrey.shade50,
                        const Color(0xFF102A43),
                      ),
                      const SizedBox(width: 10),
                      _buildActionBtn(
                        Icons.chat_bubble_outline,
                        Colors.blueGrey.shade50,
                        const Color(0xFF102A43),
                      ),
                      const Spacer(),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'أحمد',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'محترف العناية',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Row(
                            children: [
                              Text(
                                '4.8',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.star, color: Colors.amber, size: 16),
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
                      _buildDetailBox("رقم الطلب", booking?.id.substring(0, 8).toUpperCase() ?? "SC-TEMP"),
                      const SizedBox(width: 15),
                      _buildDetailBox("الخدمة المطلوبة", "غسيل VIP كامل"),
                    ],
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
    String title,
    IconData icon,
    bool isActive, {
    bool isDone = false,
  }) {
    Color color = isDone
        ? Colors.cyan
        : (isActive ? const Color(0xFF102A43) : Colors.grey.shade300);
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

  Widget _buildDetailBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
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
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF102A43),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

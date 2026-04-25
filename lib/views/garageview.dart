import 'package:flutter/material.dart';
import 'package:last/views/addvehicleview.dart';
import 'package:last/views/editvehicleview.dart';

class GarageScreen extends StatelessWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF102A43)),
                onPressed: () => Navigator.pop(context),
              )
            : const Icon(Icons.menu, color: Color(0xFF102A43)),
        title: const Text(
          'Syria Car Care',
          style: TextStyle(
            color: Color(0xFF102A43),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'PREMIUM CONCIERGE',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'كراجي',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF102A43),
              ),
            ),
            const SizedBox(
              height: 5,
              child: Align(
                alignment: Alignment.centerRight,
                child: Divider(
                  color: Colors.cyan,
                  thickness: 3,
                  endIndent: 0,
                  indent: 250,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildCarCard(
                    context,
                    "كيا سيراتو",
                    "فضي",
                    "حلب ٧٨٩١٢٣",
                    "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=1000",
                  ),
                  const SizedBox(height: 15),
                  _buildCarCard(
                    context,
                    "هيونداي توسان",
                    "أسود ملكي",
                    "دمشق ٤٤٥٥٦٦",
                    "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=1000",
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddVehicleScreen()),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B3B5A),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_circle, color: Colors.cyanAccent),
                    const SizedBox(width: 10),
                    const Text(
                      'أضف سيارة جديدة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarCard(
    BuildContext context,
    String name,
    String color,
    String plate,
    String imageUrl,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        plate,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'اللون: $color',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: _actionButton(
                        "حذف",
                        Icons.delete_outline,
                        Colors.red.shade50,
                        Colors.red,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditVehicleScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _actionButton(
                        "تعديل",
                        Icons.edit_outlined,
                        Colors.blue.shade50,
                        Colors.blueGrey,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditVehicleScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    String label,
    IconData icon,
    Color bgColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Icon(icon, size: 18, color: textColor),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ServiceStepper extends StatelessWidget {
  const ServiceStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle("٣", "الموعد", false),
        _buildStepLine(),
        _buildStepCircle("٢", "الباقة", true),
        _buildStepLine(),
        _buildStepCircle("✓", "الموقع", false, isDone: true),
      ],
    );
  }

  Widget _buildStepCircle(
    String label,
    String title,
    bool isActive, {
    bool isDone = false,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isDone
              ? Colors.cyanAccent
              : (isActive ? const Color(0xFF102A43) : Colors.grey.shade300),
          child: Text(
            label,
            style: TextStyle(
              color: isDone || !isActive ? Colors.black54 : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? const Color(0xFF102A43) : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Container(
      width: 40,
      height: 1,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.only(bottom: 20),
    );
  }
}

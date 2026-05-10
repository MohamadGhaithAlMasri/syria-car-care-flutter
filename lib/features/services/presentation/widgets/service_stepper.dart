import 'package:flutter/material.dart';

class ServiceStepper extends StatelessWidget {
  const ServiceStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle("٣", "الموعد", false, context),
        _buildStepLine(),
        _buildStepCircle("٢", "الباقة", true, context),
        _buildStepLine(),
        _buildStepCircle("✓", "الموقع", false, context, isDone: true),
      ],
    );
  }

  Widget _buildStepCircle(
    String label,
    String title,
    bool isActive,
    BuildContext context, {
    bool isDone = false,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isDone
              ? Colors.cyanAccent
              : (isActive ? Theme.of(context).primaryColor : Colors.grey.shade300),
          child: Text(
            label,
            style: TextStyle(
              color: (isDone || !isActive) 
                  ? Colors.black87 
                  : (Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white),
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
            color: isActive 
                ? (Theme.of(context).brightness == Brightness.dark ? Colors.cyanAccent : Theme.of(context).primaryColor) 
                : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
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

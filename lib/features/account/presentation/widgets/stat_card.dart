import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final bool isDark;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    this.isDark = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool effectiveDark = Theme.of(context).brightness == Brightness.dark || isDark;
    
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: (Theme.of(context).brightness == Brightness.dark && !isDark) ? Theme.of(context).cardColor : bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(
                  color: effectiveDark ? Colors.white70 : Colors.blueGrey,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: effectiveDark ? Colors.white : Theme.of(context).primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

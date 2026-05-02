import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isFirst;
  final bool isLast;
  final bool hasNavigation;
  final Widget? extra;
  final VoidCallback? onTap;

  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    this.isFirst = false,
    this.isLast = false,
    this.hasNavigation = true,
    this.extra,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: isFirst ? const Radius.circular(15) : Radius.zero,
            bottom: isLast ? const Radius.circular(15) : Radius.zero,
          ),
          border: isLast
              ? null
              : Border(bottom: BorderSide(color: Colors.grey.shade100)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFF102A43), size: 20),
            ),
            const SizedBox(width: 15),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            const Spacer(),
            if (extra != null) extra!,
            if (hasNavigation)
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

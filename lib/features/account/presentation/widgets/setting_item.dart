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
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(
            top: isFirst ? const Radius.circular(15) : Radius.zero,
            bottom: isLast ? const Radius.circular(15) : Radius.zero,
          ),
          border: isLast
              ? null
              : Border(bottom: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.transparent : Colors.grey.shade100)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Theme.of(context).textTheme.bodyLarge?.color, size: 20),
            ),
            const SizedBox(width: 15),
            Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.bodyLarge?.color)),
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

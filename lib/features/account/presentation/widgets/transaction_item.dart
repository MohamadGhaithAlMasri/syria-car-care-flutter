import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final Color amountColor;
  final IconData icon;
  final bool isHighlighted;

  const TransactionItem({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.amountColor,
    required this.icon,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: isHighlighted
            ? Border.all(color: Colors.cyanAccent, width: 1)
            : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: Icon(icon, color: Theme.of(context).textTheme.bodyLarge?.color, size: 20),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
          const Spacer(),
          Text(
            amount,
            style: TextStyle(color: amountColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

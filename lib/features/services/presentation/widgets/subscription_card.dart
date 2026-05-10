import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final bool hasPlan;
  final String planName;
  final VoidCallback onUpgradeOrSubscribe;

  const SubscriptionCard({
    super.key,
    required this.hasPlan,
    required this.planName,
    required this.onUpgradeOrSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: hasPlan
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color:
              Theme.of(context).floatingActionButtonTheme.backgroundColor ??
              Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'current_subscription'.tr(),
                    style: TextStyle(
                      color: hasPlan ? Colors.cyanAccent : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    planName,
                    style: TextStyle(
                      color: hasPlan
                          ? Colors.white
                          : Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: hasPlan ? Colors.white10 : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  hasPlan ? 'active'.tr() : 'not_subscribed'.tr(),
                  style: TextStyle(
                    color: hasPlan ? Colors.cyanAccent : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: hasPlan ? 0.6 : 0.0,
            backgroundColor:
                hasPlan ? Colors.white10 : Colors.grey.withOpacity(0.1),
            color: hasPlan ? Colors.cyanAccent : Colors.grey,
            minHeight: 8,
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onUpgradeOrSubscribe,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? (hasPlan ? Colors.cyan.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0.2))
                    : (hasPlan ? Colors.cyan : Theme.of(context).primaryColor),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                hasPlan ? 'upgrade_package'.tr() : 'subscribe_now'.tr(),
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.cyan
                      : (hasPlan ? const Color(0xFF1B3B5A) : Colors.white),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

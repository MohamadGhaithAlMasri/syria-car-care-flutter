import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  State<SubscriptionPlansScreen> createState() =>
      _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {

  final PageController _pageController = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'app_name'.tr(),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBadge('exclusive_for_subscribers'.tr(), context),
                  Text(
                    'save_with_plans'.tr(),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  Text(
                    'choose_level_desc'.tr(),
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 480,
              child: PageView(
                controller: _pageController,
                children: [

                  _buildPlanCard(
                    title: "silver_plan".tr(),
                    subtitle: "silver_desc".tr(),
                    price: "٢٠٠,٠٠٠",
                    features: [
                      "silver_feature_1".tr(),
                      "silver_feature_2".tr(),
                      "silver_feature_3".tr(),
                    ],
                    icon: Icons.stars,
                    iconColor: Colors.grey,
                    isHighlighted: false,
                    context: context,
                  ),

                  _buildPlanCard(
                    title: "gold_plan".tr(),
                    subtitle: "gold_desc".tr(),
                    price: "٤٥٠,٠٠٠",
                    features: [
                      "gold_feature_1".tr(),
                      "gold_feature_2".tr(),
                      "gold_feature_3".tr(),
                      "gold_feature_4".tr(),
                    ],
                    icon: Icons.workspace_premium,
                    iconColor: Colors.amber,
                    isHighlighted: true,
                    context: context,
                  ),

                  _buildPlanCard(
                    title: "platinum_plan".tr(),
                    subtitle: "platinum_desc".tr(),
                    price: "٧٥٠,٠٠٠",
                    features: [
                      "platinum_feature_1".tr(),
                      "platinum_feature_2".tr(),
                      "platinum_feature_3".tr(),
                      "platinum_feature_4".tr(),
                    ],
                    icon: Icons.diamond,
                    iconColor: Colors.blueAccent,
                    isHighlighted: false,
                    context: context,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'why_subscribe'.tr(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      _buildMiniFeature(
                        "save_time".tr(),
                        Icons.access_time_filled,
                        Colors.blueGrey,
                        context,
                      ),
                      const SizedBox(width: 12),
                      _buildMiniFeature(
                        "real_savings".tr(),
                        Icons.account_balance_wallet,
                        Colors.cyan,
                        context,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  _buildQueryBar(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String subtitle,
    required String price,
    required List<String> features,
    required IconData icon,
    required Color iconColor,
    bool isHighlighted = false,
    required BuildContext context,
  }) {
    Color mainColor = isHighlighted ? const Color(0xFF0A1D2E) : Theme.of(context).cardColor;
    Color textColor = isHighlighted ? Colors.white : (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black);
    Color subTextColor = isHighlighted ? Colors.white70 : Colors.grey;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15),
        ],
      ),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: subTextColor, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'syp_month'.tr(),
                style: TextStyle(
                  fontSize: 14,
                  color: (isHighlighted || Theme.of(context).brightness == Brightness.dark) ? Colors.cyanAccent : Colors.blueAccent,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: (isHighlighted || Theme.of(context).brightness == Brightness.dark) ? Colors.cyanAccent : Colors.blueAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          ...features.map((f) => _planFeature(f, context)),
          const Spacer(),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighlighted
                    ? Colors.cyanAccent
                    : Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'subscribe_now'.tr(),
                style: TextStyle(
                  color: isHighlighted ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _planFeature(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Theme.of(context).brightness == Brightness.dark ? Colors.cyanAccent : Colors.cyan,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String t, BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      t,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget _buildMiniFeature(String t, IconData i, Color c, BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(i, color: c),
          const SizedBox(height: 5),
          Text(
            t,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
        ],
      ),
    ),
  );

  Widget _buildQueryBar(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        Text(
          'have_query'.tr(),
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios, size: 14, color: Theme.of(context).textTheme.bodyLarge?.color),
      ],
    ),
  );
}

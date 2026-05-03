import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syria_car_care2/features/services/presentation/pages/tracking_report_page.dart';
import 'package:syria_car_care2/features/services/presentation/pages/schedule_page.dart';
import '../widgets/service_card.dart';
import '../widgets/extra_service_item.dart';
import '../widgets/service_stepper.dart';

class ServiceMenuScreen extends StatefulWidget {
  const ServiceMenuScreen({super.key});

  @override
  State<ServiceMenuScreen> createState() => _ServiceMenuScreenState();
}

class _ServiceMenuScreenState extends State<ServiceMenuScreen> {
  int _selectedPlan = 0;
  bool _isInteriorPolished = false;
  bool _isPremiumScented = false;
  bool _isEngineCleaned = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('app_name'.tr().toUpperCase()),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ServiceStepper(),
                  const SizedBox(height: 30),
                  Text(
                    'select_wash_type'.tr(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  Text(
                    'select_package_quote'.tr(),
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 25),
                  ServiceCard(
                    title: "economy_plan".tr(),
                    desc: "economy_desc".tr(),
                    price: "price_economy".tr(),
                    icon: Icons.water_drop,
                    isSelected: _selectedPlan == 0,
                    onTap: () => setState(() => _selectedPlan = 0),
                  ),
                  ServiceCard(
                    title: "full_plan".tr(),
                    desc: "full_desc".tr(),
                    price: "price_full".tr(),
                    icon: Icons.auto_awesome,
                    isSelected: _selectedPlan == 1,
                    onTap: () => setState(() => _selectedPlan = 1),
                  ),
                  ServiceCard(
                    title: "winter_plan".tr(),
                    desc: "winter_desc".tr(),
                    price: "price_winter".tr(),
                    icon: Icons.ac_unit,
                    isSelected: _selectedPlan == 2,
                    onTap: () => setState(() => _selectedPlan = 2),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'optional'.tr(),
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'extra_services'.tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ExtraServiceItem(
                    title: "interior_polish".tr(),
                    price: "price_polish".tr(),
                    value: _isInteriorPolished,
                    onChanged: (val) =>
                        setState(() => _isInteriorPolished = val!),
                  ),
                  ExtraServiceItem(
                    title: "premium_scent".tr(),
                    price: "price_scent".tr(),
                    value: _isPremiumScented,
                    onChanged: (val) =>
                        setState(() => _isPremiumScented = val!),
                  ),
                  ExtraServiceItem(
                    title: "engine_clean".tr(),
                    price: "price_engine".tr(),
                    value: _isEngineCleaned,
                    onChanged: (val) => setState(() => _isEngineCleaned = val!),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Theme.of(context).brightness == Brightness.dark ? Colors.transparent : Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScheduleBookingScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 18),
                  SizedBox(width: 10),
                  Text(
                    'next'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'approx_total'.tr(),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                'total_price_mock'.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

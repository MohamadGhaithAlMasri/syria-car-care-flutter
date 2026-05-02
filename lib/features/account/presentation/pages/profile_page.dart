import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syria_car_care2/features/auth/presentation/pages/login_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/pages/garage_page.dart';
import '../widgets/stat_card.dart';
import '../widgets/setting_item.dart';
import '../widgets/language_toggle.dart';
import '../widgets/section_title.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'app_name'.tr(),
          style: TextStyle(
            color: Color(0xFF102A43),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [

                      Container(
                        width: 110,
                        height: 110,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.cyan, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150',
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF102A43),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'bronze_member'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  Text(
                    'mock_user_name'.tr(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  Text(
                    'mock_user_phone'.tr(),
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                StatCard(
                  title: "registered_cars".tr(),
                  value: "03",
                  icon: Icons.directions_car,
                  bgColor: Colors.blue.shade50,
                  iconColor: Colors.blue,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GarageScreen(),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                StatCard(
                  title: "current_points".tr(),
                  value: "1,250",
                  icon: Icons.stars,
                  bgColor: Color(0xFF1B3B5A),
                  iconColor: Colors.cyanAccent,
                  isDark: true,
                ),
              ],
            ),
            const SizedBox(height: 30),
            SectionTitle(title: "general_settings".tr()),
            SettingItem(
              title: "saved_cars".tr(),
              icon: Icons.directions_car_filled,
              isFirst: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GarageScreen()),
                );
              },
            ),
            SettingItem(title: "addresses".tr(), icon: Icons.location_on),
            SettingItem(
              title: "booking_history".tr(),
              icon: Icons.history,
              isLast: true,
            ),
            const SizedBox(height: 25),
            SectionTitle(title: "support_language".tr()),
            const LanguageToggle(),
            SettingItem(
              title: "tech_support".tr(),
              icon: Icons.headset_mic,
              hasNavigation: false,
              extra: Icon(
                Icons.chat_bubble_outline,
                color: Colors.cyan,
                size: 20,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text('logout_confirm_title'.tr()),
                      content: Text('logout_confirm_msg'.tr()),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text(
                            'cancel'.tr(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove('isLoggedIn');
                            await Supabase.instance.client.auth.signOut();
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'confirm'.tr(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      'logout'.tr(),
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

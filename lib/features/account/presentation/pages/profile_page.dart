import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syria_car_care2/features/auth/presentation/pages/login_page.dart';
import 'package:syria_car_care2/features/services/presentation/pages/my_bookings_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/pages/garage_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syria_car_care2/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import '../widgets/stat_card.dart';
import '../widgets/setting_item.dart';
import '../widgets/language_toggle.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/section_title.dart';
import '../widgets/profile_avatar.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'saved_addresses_page.dart';

import '../bloc/account_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isUploading = false;

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      if (mounted) {
        setState(() => _isUploading = true);
        context.read<AccountBloc>().add(
          UploadAvatarEvent(filePath: image.path),
        );

        // We'll reset uploading state after a delay or when state changes
        // For simplicity, we'll wait a bit then reset,
        // as the Bloc will trigger a refresh anyway.
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) setState(() => _isUploading = false);
        });
      }
    }
  }

  Future<void> _launchWhatsApp() async {
    const phoneNumber = "+963992922651";
    final url = Uri.parse("whatsapp://send?phone=$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      final webUrl = Uri.parse("https://wa.me/$phoneNumber");
      if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Could not launch WhatsApp")),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(GetAccountInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'app_name'.tr(),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  String name = user?.userMetadata?['full_name'] ?? 'user'.tr();
                  String email = user?.email ?? '';
                  String? phoneNumber;
                  if (state is AccountLoaded) {
                    name = state.accountInfo.name;
                    email = state.accountInfo.email;
                    phoneNumber = state.accountInfo.phoneNumber;
                  }
                  return Column(
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
                            child: GestureDetector(
                              onTap: _isUploading ? null : _pickAndUploadImage,
                              child: ProfileAvatar(
                                radius: 50,
                                child: _isUploading
                                    ? const CircularProgressIndicator(
                                        color: Colors.cyan,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              (state is AccountLoaded &&
                                      state.accountInfo.plan != null &&
                                      state.accountInfo.plan!.isNotEmpty)
                                  ? state.accountInfo.plan!
                                  : 'not_subscribed'.tr(),
                              style: TextStyle(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      if (phoneNumber != null && phoneNumber.isNotEmpty) ...[
                        const SizedBox(height: 5),
                        Text(
                          phoneNumber,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                BlocBuilder<VehiclesBloc, VehiclesState>(
                  builder: (context, state) {
                    String count = "00";
                    if (state is VehiclesLoaded) {
                      count = state.vehicles.length.toString().padLeft(2, '0');
                    }
                    return StatCard(
                      title: "registered_cars".tr(),
                      value: count,
                      icon: Icons.directions_car,
                      bgColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      iconColor: Theme.of(context).primaryColor,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GarageScreen(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 15),
                BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                    String points = "0";
                    if (state is AccountLoaded) {
                      points = state.accountInfo.points.toString();
                    }
                    return StatCard(
                      title: "current_points".tr(),
                      value: points,
                      icon: Icons.stars,
                      bgColor: const Color(0xFF1B3B5A),
                      iconColor: Colors.cyanAccent,
                      isDark: true,
                    );
                  },
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
            SettingItem(
              title: "addresses".tr(),
              icon: Icons.location_on,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedAddressesScreen(),
                  ),
                );
              },
            ),
            SettingItem(
              title: "booking_history".tr(),
              icon: Icons.history,
              isLast: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyBookingsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            SectionTitle(title: "support_language".tr()),
            const LanguageToggle(),
            const ThemeToggle(),
            SettingItem(
              title: "tech_support".tr(),
              icon: Icons.headset_mic,
              hasNavigation: false,
              isLast: true,
              onTap: _launchWhatsApp,
              extra: const Icon(
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
                    const Icon(Icons.logout, color: Colors.red),
                    const SizedBox(width: 10),
                    Text(
                      'logout'.tr(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    throw StateError('This is test exception');
                  } catch (e, stackTrace) {
                    await Sentry.captureException(e, stackTrace: stackTrace);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إرسال الخطأ إلى Sentry بنجاح!')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Verify Sentry Setup',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ),
    );
  }
}

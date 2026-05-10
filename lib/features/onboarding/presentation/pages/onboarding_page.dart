import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syria_car_care2/features/auth/presentation/pages/login_page.dart';
import '../widgets/benefit_card.dart';
import '../widgets/info_card.dart';
import '../widgets/onboarding_step.dart';
import '../widgets/onboarding_footer.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  Future<void> _goToLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
    
    if (!mounted) return;
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              children: [
                OnboardingStep(
                  image: "assets/images/onboarding111.jpeg",
                  title: "onboarding_title_1".tr(),
                  subtitle: "onboarding_subtitle_1".tr(),
                  tag: "PREMIUM SERVICE",
                ),
                OnboardingStep(
                  image: "assets/images/onboarding22.jpeg",
                  title: "onboarding_title_2".tr(),
                  subtitle: "onboarding_subtitle_2".tr(),
                  tag: "ELITE PRECISION",
                  extraWidget: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      InfoCard(icon: Icons.access_time, text: "instant_booking".tr()),
                      InfoCard(icon: Icons.location_on, text: "full_coverage".tr()),
                    ],
                  ),
                ),
                OnboardingStep(
                  image: "assets/images/onboarding33.jpeg",
                  title: "onboarding_title_3".tr(),
                  subtitle: "onboarding_subtitle_3".tr(),
                  extraWidget: Row(
                    children: [
                      Expanded(
                        child: BenefitCard(
                          icon: Icons.calendar_today_outlined,
                          title: "benefit_priority_title".tr(),
                          desc: "benefit_priority_desc".tr(),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: BenefitCard(
                          icon: Icons.savings_outlined,
                          title: "benefit_savings_title".tr(),
                          desc: "benefit_savings_desc".tr(),
                        ),
                      ),
                    ],
                  ),
                  isLastPage: true,
                ),
              ],
            ),
          ),
          OnboardingFooter(
            currentIndex: _currentIndex,
            controller: _controller,
            onStart: _goToLogin,
            onSkip: _goToLogin,
          ),
        ],
      ),
    );
  }
}

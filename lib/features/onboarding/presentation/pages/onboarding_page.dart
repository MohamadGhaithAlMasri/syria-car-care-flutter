import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syria_car_care2/features/auth/presentation/pages/login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final Color primaryColor = const Color(0xFF102A43);
  final Color accentColor = const Color(0xFF00E5FF);

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              children: [_buildStep1(), _buildStep2(), _buildStep3()],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return _baseLayout(
      image: "assets/images/onboarding111.jpeg",
      title: "onboarding_title_1".tr(),
      subtitle: "onboarding_subtitle_1".tr(),
      tag: "PREMIUM SERVICE",
    );
  }

  Widget _buildStep2() {
    return _baseLayout(
      image: "assets/images/onboarding22.jpeg",
      title: "onboarding_title_2".tr(),
      subtitle: "onboarding_subtitle_2".tr(),
      tag: "ELITE PRECISION",
      extraWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _infoCard(Icons.access_time, "instant_booking".tr()),
          const SizedBox(width: 10),
          _infoCard(Icons.location_on, "full_coverage".tr()),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return _baseLayout(
      image: "assets/images/onboarding33.jpeg",
      title: "onboarding_title_3".tr(),
      subtitle: "onboarding_subtitle_3".tr(),
      extraWidget: Row(
        children: [
          Expanded(
            child: _benefitCard(
              Icons.calendar_today_outlined,
              "benefit_priority_title".tr(),
              "benefit_priority_desc".tr(),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _benefitCard(
              Icons.savings_outlined,
              "benefit_savings_title".tr(),
              "benefit_savings_desc".tr(),
            ),
          ),
        ],
      ),
      isLastPage: true,
    );
  }

  Widget _baseLayout({
    required String image,
    required String title,
    required String subtitle,
    String? tag,
    bool isLastPage = false,
    Widget? extraWidget,
  }) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, primaryColor.withOpacity(0.8)],
                ),
              ),
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tag != null)
                    Text(
                      tag,
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                if (extraWidget != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: extraWidget,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _benefitCard(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accentColor, size: 32),
          const SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: accentColor),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                if (_currentIndex < 2) {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else {
                  _goToLogin();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                _currentIndex == 2 ? "start_now".tr() : "next".tr(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 15),

          TextButton(
            onPressed: _goToLogin,
            child: Text(
              "skip".tr(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: _currentIndex == index ? 25 : 6,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? accentColor
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

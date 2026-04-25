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
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Color(0xFF102A43)),
        title: const Text(
          'Syria Car Care',
          style: TextStyle(
            color: Color(0xFF102A43),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBadge('حصري للمشتركين'),
                  const Text(
                    'وفر المال مع باقاتنا الشهرية',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  const Text(
                    'اختر المستوى الذي يناسب احتياجات سيارتك واستمتع بخدماتنا.',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 1. منطقة الباقات القابلة للتمرير (Horizontal Scroll)
            SizedBox(
              height: 480,
              child: PageView(
                controller: _pageController,
                padEnds: true,
                children: [
                  // الباقة الفضية
                  _buildPlanCard(
                    title: "الباقة الفضية",
                    subtitle: "للعناية الأساسية المنتظمة",
                    price: "٢٠٠,٠٠٠",
                    features: [
                      "٤ غسلات شاملة",
                      "تنظيف داخلي عميق",
                      "تعطير السيارة مجاناً",
                    ],
                    icon: Icons.stars,
                    iconColor: Colors.grey,
                    isDark: false,
                  ),
                  // الباقة الذهبية (من الصورة الجديدة)
                  _buildPlanCard(
                    title: "الذهبية",
                    subtitle: "التوازن المثالي بين السعر والخدمة",
                    price: "٤٥٠,٠٠٠",
                    features: [
                      "٨ غسلات شاملة",
                      "تلميع مجاني (مرة واحدة)",
                      "أولوية الحجز عبر التطبيق",
                      "تنظيف المحرك الجاف",
                    ],
                    icon: Icons.workspace_premium,
                    iconColor: Colors.amber,
                    isDark: true, // تصميم داكن كما في الصورة
                  ),
                  // الباقة البلاتينية (من الصورة الجديدة)
                  _buildPlanCard(
                    title: "البلاتينية",
                    subtitle: "عناية متميزة بلا حدود",
                    price: "٧٥٠,٠٠٠",
                    features: [
                      "غسيل غير محدود",
                      "حماية نانو سيراميك سريعة",
                      "خدمة استلام وتسليم السيارة",
                      "خصم ٢٠٪ على قطع الغيار",
                    ],
                    icon: Icons.diamond,
                    iconColor: Colors.blueAccent,
                    isDark: false,
                  ),
                ],
              ),
            ),

            // 2. قسم المزايا الإضافية (كما في التصميم السابق)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'لماذا تشترك معنا؟',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      _buildMiniFeature(
                        "توفير الوقت",
                        Icons.access_time_filled,
                        Colors.blueGrey,
                      ),
                      const SizedBox(width: 12),
                      _buildMiniFeature(
                        "توفير حقيقي",
                        Icons.account_balance_wallet,
                        Colors.cyan,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildQueryBar(),
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
    bool isDark = false,
  }) {
    Color mainColor = isDark ? const Color(0xFF0A1D2E) : Colors.white;
    Color textColor = isDark ? Colors.white : const Color(0xFF102A43);
    Color subTextColor = isDark ? Colors.white70 : Colors.grey;

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
                crossAxisAlignment: CrossAxisAlignment.end,
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
                'ل.س / شهر',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.cyanAccent : Colors.blueAccent,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.cyanAccent : Colors.blueAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ...features.map((f) => _planFeature(f, isDark)).toList(),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark
                    ? Colors.cyanAccent
                    : const Color(0xFF1B3B5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'اشترك الآن',
                style: TextStyle(
                  color: isDark ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _planFeature(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF102A43),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            Icons.check_circle,
            color: isDark ? Colors.cyanAccent : Colors.cyan,
            size: 20,
          ),
        ],
      ),
    );
  }

  // ودجت المزايا الصغيرة والبارك السفلي
  Widget _buildBadge(String t) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      t,
      style: const TextStyle(
        color: Colors.blue,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget _buildMiniFeature(String t, IconData i, Color c) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(i, color: c),
          const SizedBox(height: 5),
          Text(
            t,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );

  Widget _buildQueryBar() => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(15),
    ),
    child: const Row(
      children: [
        Icon(Icons.arrow_back_ios, size: 14),
        Spacer(),
        Text(
          'لديك استفسار؟ تعرف على الشروط',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

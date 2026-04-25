import 'package:flutter/material.dart';
import 'package:last/views/tracking_report.dart';

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
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF102A43)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'SYRIA CAR CARE',
          style: TextStyle(
            color: Color(0xFF102A43),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildStepper(),
                  const SizedBox(height: 30),
                  const Text(
                    'اختر نوع الغسيل',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  const Text(
                    'اختر الباقة التي تناسب احتياجات سيارتك اليوم',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 25),
                  _buildServiceCard(
                    0,
                    "الاقتصادية",
                    "غسيل خارجي سريع مع تنظيف الإطارات وتنشيف يدوي احترافي.",
                    "٥٠,٠٠٠ ل.س",
                    Icons.water_drop,
                  ),
                  _buildServiceCard(
                    1,
                    "الكاملة",
                    "تنظيف شامل داخلي وخارجي، تلميع الطبلون، واكس حماية، وتعطير.",
                    "٨٥,٠٠٠ ل.س",
                    Icons.auto_awesome,
                  ),
                  _buildServiceCard(
                    2,
                    "الشتوية",
                    "حماية مضاعفة من الأملاح والوحل، طبقة نانو سريعة، وتنظيف أسفل السيارة.",
                    "١٢٠,٠٠٠ ل.س",
                    Icons.ac_unit,
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
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'اختياري',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        'خدمات إضافية',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF102A43),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildExtraService(
                    "تلميع داخلي",
                    "١٥,٠٠٠ ل.س+",
                    _isInteriorPolished,
                    (val) => setState(() => _isInteriorPolished = val!),
                  ),
                  _buildExtraService(
                    "تعطير بريميوم",
                    "٥,٠٠٠ ل.س+",
                    _isPremiumScented,
                    (val) => setState(() => _isPremiumScented = val!),
                  ),
                  _buildExtraService(
                    "تنظيف الموتور",
                    "٢٥,٠٠٠ ل.س+",
                    _isEngineCleaned,
                    (val) => setState(() => _isEngineCleaned = val!),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _stepCircle("٣", "الموعد", false),
        _stepLine(),
        _stepCircle("٢", "الباقة", true),
        _stepLine(),
        _stepCircle("✓", "الموقع", false, isDone: true),
      ],
    );
  }

  Widget _stepCircle(
    String label,
    String title,
    bool isActive, {
    bool isDone = false,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isDone
              ? Colors.cyanAccent
              : (isActive ? const Color(0xFF102A43) : Colors.grey.shade300),
          child: Text(
            label,
            style: TextStyle(
              color: isDone || !isActive ? Colors.black54 : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? const Color(0xFF102A43) : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _stepLine() {
    return Container(
      width: 40,
      height: 1,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.only(bottom: 20),
    );
  }

  Widget _buildServiceCard(
    int index,
    String title,
    String desc,
    String price,
    IconData icon,
  ) {
    bool isSelected = _selectedPlan == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.cyanAccent : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Text(
              price,
              style: const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    desc,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.cyan),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExtraService(
    String title,
    String price,
    bool value,
    Function(bool?) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF102A43),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const Spacer(),
          Text(price, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const Spacer(),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
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
                  MaterialPageRoute(builder: (context) => const LiveTrackingScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B3B5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 18),
                  SizedBox(width: 10),
                  Text(
                    'التالي',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'المجموع التقريبي',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                '٧٥,٠٠٠ ل.س',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF102A43),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

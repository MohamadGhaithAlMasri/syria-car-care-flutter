import 'package:flutter/material.dart';

class ScheduleBookingScreen extends StatefulWidget {
  const ScheduleBookingScreen({super.key});

  @override
  State<ScheduleBookingScreen> createState() => _ScheduleBookingScreenState();
}

class _ScheduleBookingScreenState extends State<ScheduleBookingScreen> {
  int _selectedDay = 14;
  String _selectedTime = "02:00 PM";

  final List<String> _timeSlots = [
    "09:00 AM",
    "10:30 AM",
    "12:00 PM",
    "01:30 PM",
    "02:00 PM",
    "04:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'تحديد الموعد',
          style: TextStyle(
            color: Color(0xFF102A43),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF102A43)),
          onPressed: () => Navigator.pop(context),
        ),
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
                    'اختر التاريخ والوقت',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  const Text(
                    'حدد الموعد الأنسب لوصول فريقنا إليك',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'أبريل 2024',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        int day = 12 + index;
                        bool isSelected = _selectedDay == day;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedDay = day),
                          child: Container(
                            width: 65,
                            margin: const EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF102A43)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: isSelected
                                  ? [
                                      const BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${day}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF102A43),
                                  ),
                                ),
                                Text(
                                  'السبت',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isSelected
                                        ? Colors.cyanAccent
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'الأوقات المتاحة',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                    itemCount: _timeSlots.length,
                    itemBuilder: (context, index) {
                      bool isSelected = _selectedTime == _timeSlots[index];
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedTime = _timeSlots[index]),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.cyanAccent
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.cyan
                                  : Colors.grey.shade100,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _timeSlots[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? const Color(0xFF102A43)
                                  : Colors.blueGrey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.edit_calendar, color: Colors.cyan),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'ملخص الموعد',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '$_selectedDay أبريل، الساعة $_selectedTime',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF102A43),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
        _stepCircle("٣", "الموعد", true),
        _stepLine(isActive: true),
        _stepCircle("٢", "الباقة", false, isDone: true),
        _stepLine(isActive: true),
        _stepCircle("١", "الموقع", false, isDone: true),
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
          radius: 14,
          backgroundColor: isDone
              ? Colors.cyanAccent
              : (isActive ? const Color(0xFF102A43) : Colors.grey.shade300),
          child: Text(
            label,
            style: TextStyle(
              color: isDone || !isActive ? Colors.black87 : Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
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

  Widget _stepLine({bool isActive = false}) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? Colors.cyanAccent : Colors.grey.shade300,
      margin: const EdgeInsets.only(bottom: 18),
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
            width: 180,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B3B5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'تأكيد الحجز',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'المجموع الكلي',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                '٨٥,٠٠٠ ل.س',
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

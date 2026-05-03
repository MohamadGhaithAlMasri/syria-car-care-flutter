import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syria_car_care2/features/services/presentation/bloc/bookings_bloc.dart';

import '../../domain/entities/booking.dart';
import 'tracking_report_page.dart';

class ScheduleBookingScreen extends StatefulWidget {
  const ScheduleBookingScreen({super.key});

  @override
  State<ScheduleBookingScreen> createState() => _ScheduleBookingScreenState();
}

class _ScheduleBookingScreenState extends State<ScheduleBookingScreen> {
  int _selectedDay = DateTime.now().day;
  String _selectedTime = "09:00 AM";
  bool _isImmediate = true;

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

    return BlocListener<BookingsBloc, BookingsState>(
      listener: (context, state) {
        if (state is BookingCreated) {
          if (_isImmediate) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    LiveTrackingScreen(booking: state.booking),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'تم جدولة طلبك بنجاح! يمكنك تتبعه من قائمة طلباتي',
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        } else if (state is BookingsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('تحديد الموعد'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
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
                    Text(
                      'متى تريد الخدمة؟',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const Text(
                      'اختر الوقت المناسب لك للحصول على الخدمة',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: _buildTypeCard(
                            title: 'موعد لاحق',
                            icon: Icons.calendar_month,
                            isSelected: !_isImmediate,
                            onTap: () => setState(() => _isImmediate = false),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildTypeCard(
                            title: 'أسرع وقت (فوراً)',
                            icon: Icons.bolt,
                            isSelected: _isImmediate,
                            onTap: () => setState(() => _isImmediate = true),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    if (!_isImmediate) ...[
                      Text(
                        'أبريل 2024',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
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
                            int day = DateTime.now().day + index;
                            bool isSelected = _selectedDay == day;
                            return InkWell(
                              onTap: () => setState(() => _selectedDay = day),
                              child: Container(
                                width: 65,
                                margin: const EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).cardColor,
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
                                      '$day',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? Colors.white
                                            : Theme.of(context).textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                    Text(
                                      'اليوم',
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
                      Text(
                        'الأوقات المتاحة',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
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
                          return InkWell(
                            onTap: () => setState(
                              () => _selectedTime = _timeSlots[index],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.cyanAccent
                                    : Theme.of(context).cardColor,
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
                                      ? Theme.of(context).primaryColor
                                      : Colors.blueGrey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.cyan.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.cyan.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.bolt,
                              color: Colors.cyan,
                              size: 40,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'سيصل فريقنا إليك في أسرع وقت ممكن',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'الوقت المتوقع للوصول: ٢٥-٤٠ دقيقة',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.cyanAccent : Colors.grey,
              size: 30,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
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
              : (isActive ? Theme.of(context).primaryColor : Colors.grey.shade300),
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
            color: isActive
                ? Theme.of(context).textTheme.bodyLarge?.color
                : Colors.grey,
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
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.transparent : Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<BookingsBloc, BookingsState>(
            builder: (context, state) {
              return SizedBox(
                width: 180,
                height: 55,
                child: ElevatedButton(
                  onPressed: state is BookingsLoading
                      ? null
                      : () {
                          final booking = Booking(
                            id: '',
                            vehicleId: '776d6c2a-9e7b-4b2a-8c9e-7b4b2a8c9e7b',
                            serviceId: 'a1b2c3d4-e5f6-4a5b-8c9d-0e1f2a3b4c5d',
                            scheduledAt: _isImmediate
                                ? null
                                : DateTime(2024, 4, _selectedDay, 14),
                            status: 'pending',
                            totalPrice: 85000,
                            latitude: 33.5138,
                            longitude: 36.2765,
                          );
                          context.read<BookingsBloc>().add(
                            CreateBookingEvent(booking),
                          );
                        },
                  child: state is BookingsLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'تأكيد الحجز',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              );
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'المجموع الكلي',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                '٨٥,٠٠٠ ل.س',
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

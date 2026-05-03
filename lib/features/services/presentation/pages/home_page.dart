import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syria_car_care2/features/services/presentation/bloc/bookings_bloc.dart';
import 'package:syria_car_care2/features/services/presentation/pages/location_selection_page.dart';
import 'package:syria_car_care2/features/account/presentation/pages/subscription_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/pages/add_vehicle_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/pages/edit_vehicle_page.dart';
import 'package:syria_car_care2/features/services/presentation/pages/schedule_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:syria_car_care2/features/services/presentation/pages/tracking_report_page.dart';
import '../widgets/quick_action_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<VehiclesBloc>().add(LoadVehiclesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('app_name'.tr()),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'good_morning'.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
            ),
            Text('care_quote'.tr(), style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'active'.tr(),
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 12,
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'current_subscription'.tr(),
                            style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'active_package'.tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  const LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.white10,
                    color: Colors.cyanAccent,
                    minHeight: 8,
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SubscriptionPlansScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'upgrade_package'.tr(),
                        style: TextStyle(
                          color: Color(0xFF1B3B5A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'current_orders'.tr(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      'view_all'.tr(),
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            BlocBuilder<BookingsBloc, BookingsState>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.cyan.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.timer_outlined,
                          color: Colors.cyan,
                        ),
                      ),
                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'غسيل بريميوم - كيا ريو',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Text(
                              'الموعد: اليوم، الساعة ٠٤:٠٠ م',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LiveTrackingScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'track'.tr(),
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 25),

            Row(
              children: [
                QuickActionCard(
                  icon: Icons.calendar_month,
                  title: "schedule_later".tr(),
                  bgColor: Colors.teal,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScheduleBookingScreen(),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                QuickActionCard(
                  icon: Icons.water_drop,
                  title: "wash_now".tr(),
                  bgColor: Colors.blue.shade100,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationSelectionScreen(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'my_cars'.tr(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddVehicleScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      'add_car'.tr(),
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            BlocBuilder<VehiclesBloc, VehiclesState>(
              builder: (context, state) {
                if (state is VehiclesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VehiclesLoaded) {
                  if (state.vehicles.isEmpty) {
                    return Center(child: Text('no_cars_yet'.tr()));
                  }
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.vehicles.length,
                      itemBuilder: (context, index) {
                        final vehicle = state.vehicles[index];
                        return Container(
                          width: 250,
                          margin: const EdgeInsets.only(left: 15),
                          child: Material(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                            elevation: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditVehicleScreen(vehicle: vehicle),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=1000',
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.directions_car,
                                          color: Colors.grey,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${vehicle.brand} ${vehicle.model}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                              ),
                                            ),
                                            Text(
                                              vehicle.plateNumber,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
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
                        );
                      },
                    ),
                  );
                } else if (state is VehiclesError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syria_car_care2/features/account/presentation/bloc/account_bloc.dart';
import 'package:syria_car_care2/features/services/presentation/bloc/bookings_bloc.dart';
import 'package:syria_car_care2/features/services/presentation/pages/location_selection_page.dart';
import 'package:syria_car_care2/features/account/presentation/pages/subscription_page.dart';
import 'package:syria_car_care2/features/services/presentation/pages/my_bookings_page.dart';
import 'package:syria_car_care2/features/vehicles/domain/entities/vehicle.dart';
import 'package:syria_car_care2/features/vehicles/presentation/pages/add_vehicle_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/pages/edit_vehicle_page.dart';
import 'package:syria_car_care2/features/services/presentation/pages/schedule_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:syria_car_care2/features/services/presentation/pages/tracking_report_page.dart';
import '../widgets/quick_action_card.dart';
import 'package:syria_car_care2/features/account/presentation/widgets/profile_avatar.dart';

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
    context.read<AccountBloc>().add(GetAccountInfoEvent());
    context.read<BookingsBloc>().add(GetMyBookingsEvent());
  }

  void _showVehicleSelection(
    BuildContext context,
    List<Vehicle> vehicles, {
    bool isScheduling = false,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'select_car'.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = vehicles[index];
                  return ListTile(
                    title: Text('${vehicle.brand} ${vehicle.model}'),
                    subtitle: Text(vehicle.plateNumber),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => isScheduling
                              ? ScheduleBookingScreen(vehicleId: vehicle.id)
                              : LocationSelectionScreen(vehicleId: vehicle.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context, String bookingId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('cancel_order_title'.tr()),
        content: Text('cancel_order_msg'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('later'.tr()),
          ),
          TextButton(
            onPressed: () {
              context.read<BookingsBloc>().add(CancelBookingEvent(bookingId));
              Navigator.pop(context);
            },
            child: const Text(
              'تأكيد الإلغاء',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
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
            child: ProfileAvatar(),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<BookingsBloc, BookingsState>(
            listener: (context, state) {
              if (state is BookingsLoaded) {
                // Refresh balance when bookings change (e.g. after cancellation/refund)
                context.read<AccountBloc>().add(GetAccountInfoEvent());
              } else if (state is BookingsError) {
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                String userName = "";
                if (state is AccountLoaded) {
                  userName = state.accountInfo.name;
                }
                return Text(
                  '${'good_morning'.tr()}${userName.isNotEmpty ? ', $userName' : ''}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 24),
                );
              },
            ),
            Text('care_quote'.tr(), style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                bool hasPlan = false;
                String planName = 'no_plan'.tr();
                if (state is AccountLoaded &&
                    state.accountInfo.plan != null &&
                    state.accountInfo.plan!.isNotEmpty) {
                  hasPlan = true;
                  planName = state.accountInfo.plan!;
                }

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: hasPlan
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color:
                          Theme.of(
                            context,
                          ).floatingActionButtonTheme.backgroundColor ??
                          Theme.of(context).colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'current_subscription'.tr(),
                                style: TextStyle(
                                  color: hasPlan
                                      ? Colors.cyanAccent
                                      : Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                planName,
                                style: TextStyle(
                                  color: hasPlan
                                      ? Colors.white
                                      : Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: hasPlan
                                  ? Colors.white10
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              hasPlan ? 'active'.tr() : 'not_subscribed'.tr(),
                              style: TextStyle(
                                color: hasPlan ? Colors.cyanAccent : Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      LinearProgressIndicator(
                        value: hasPlan ? 0.6 : 0.0,
                        backgroundColor: hasPlan
                            ? Colors.white10
                            : Colors.grey.withOpacity(0.1),
                        color: hasPlan ? Colors.cyanAccent : Colors.grey,
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
                            backgroundColor: hasPlan
                                ? Colors.cyan
                                : Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            hasPlan
                                ? 'upgrade_package'.tr()
                                : 'subscribe_now'.tr(),
                            style: TextStyle(
                              color: hasPlan
                                  ? const Color(0xFF1B3B5A)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'current_orders'.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 18),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyBookingsScreen(),
                      ),
                    );
                  },
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
                if (state is BookingsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookingsLoaded) {
                  final activeStatuses = ['pending', 'accepted', 'washing'];
                  final currentBookings = state.bookings.where((b) => activeStatuses.contains(b.status)).toList();
                  if (currentBookings.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'no_orders_yet'.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }
                  final booking = currentBookings.first;
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
                                booking.status == 'pending'
                                    ? 'جاري المعالجة'
                                    : booking.status == 'cancelled'
                                        ? 'تم الإلغاء'
                                        : 'طلب مكتمل',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: booking.status == 'washing' 
                                      ? Colors.cyan 
                                      : Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                              Text(
                                booking.status == 'washing' 
                                    ? 'جاري الغسيل الآن...' 
                                    : booking.status == 'accepted' 
                                        ? 'السائق في الطريق' 
                                        : 'جاري المعالجة',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${'approx_total'.tr()}: ${booking.totalPrice} ل.س',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        if (booking.status == 'pending')
                          TextButton(
                            onPressed: () => _showCancelConfirmation(context, booking.id),
                            child: Text(
                              'cancel'.tr(),
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        const SizedBox(width: 5),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LiveTrackingScreen(booking: booking),
                              ),
                            );
                          },
                          child: Text(
                            'track'.tr(),
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 25),

            Row(
              children: [
                QuickActionCard(
                  icon: Icons.calendar_month,
                  title: "schedule_later".tr(),
                  bgColor: Colors.teal,
                  onTap: () {
                    final vehicleState = context.read<VehiclesBloc>().state;
                    if (vehicleState is VehiclesLoaded) {
                      if (vehicleState.vehicles.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('please_add_car_first'.tr())),
                        );
                      } else if (vehicleState.vehicles.length == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScheduleBookingScreen(
                              vehicleId: vehicleState.vehicles.first.id,
                            ),
                          ),
                        );
                      } else {
                        // إظهار قائمة الاختيار وتمرير الصفحة المستهدفة كـ ScheduleBookingScreen
                        _showVehicleSelection(
                          context,
                          vehicleState.vehicles,
                          isScheduling: true,
                        );
                      }
                    }
                  },
                ),
                const SizedBox(width: 15),
                QuickActionCard(
                  icon: Icons.water_drop,
                  title: "wash_now".tr(),
                  bgColor: Colors.blue.shade100,
                  onTap: () {
                    final vehicleState = context.read<VehiclesBloc>().state;
                    if (vehicleState is VehiclesLoaded) {
                      if (vehicleState.vehicles.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('please_add_car_first'.tr())),
                        );
                      } else if (vehicleState.vehicles.length == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationSelectionScreen(
                              vehicleId: vehicleState.vehicles.first.id,
                            ),
                          ),
                        );
                      } else {
                        _showVehicleSelection(context, vehicleState.vehicles);
                      }
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'my_cars'.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 18),
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
                                      vehicle.imageUrl ??
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
                                                color: Theme.of(
                                                  context,
                                                ).textTheme.bodyLarge?.color,
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
    ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

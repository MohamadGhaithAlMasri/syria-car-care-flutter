import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syria_car_care2/features/account/presentation/bloc/account_bloc.dart';
import '../bloc/bookings_bloc.dart';
import 'tracking_report_page.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('current_orders'.tr()),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'current_orders'.tr()),
              Tab(text: 'booking_history'.tr()),
            ],
            indicatorColor: Colors.cyanAccent,
            labelColor: Colors.cyanAccent,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: BlocListener<BookingsBloc, BookingsState>(
          listener: (context, state) {
            if (state is BookingsLoaded) {
              context.read<AccountBloc>().add(GetAccountInfoEvent());
            } else if (state is BookingsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<BookingsBloc, BookingsState>(
            builder: (context, state) {
              if (state is BookingsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BookingsLoaded) {
                final currentBookings =
                    state.bookings.where((b) => b.status == 'pending').toList();
                final historyBookings =
                    state.bookings.where((b) => b.status != 'pending').toList();

                return TabBarView(
                  children: [
                    _buildBookingList(context, currentBookings),
                    _buildBookingList(context, historyBookings),
                  ],
                );
              } else if (state is BookingsError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBookingList(BuildContext context, List<dynamic> bookings) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            Text(
              'no_orders_yet'.tr(),
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _buildBookingCard(context, booking);
      },
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
            child: Text('later'.tr()), // "لاحقاً" or similar to mean "not now"
          ),
          TextButton(
            onPressed: () {
              context.read<BookingsBloc>().add(CancelBookingEvent(bookingId));
              Navigator.pop(context);
            },
            child: const Text(
              'تأكيد الإلغاء', // Hardcoded for clarity since it's a critical fix
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, dynamic booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
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
            child: const Icon(Icons.timer_outlined, color: Colors.cyan),
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
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  '${'approx_total'.tr()}: ${booking.totalPrice} ل.س',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
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
          if (booking.status == 'pending')
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LiveTrackingScreen(booking: booking),
                  ),
                );
              },
              child: Text(
                'track'.tr(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

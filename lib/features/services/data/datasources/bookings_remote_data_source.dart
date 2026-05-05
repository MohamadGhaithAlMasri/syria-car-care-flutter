import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booking_model.dart';

abstract class BookingsRemoteDataSource {
  Future<BookingModel> createBooking(BookingModel booking);
  Future<List<BookingModel>> getMyBookings();
  Future<BookingModel> getBookingStatus(String bookingId);
  Future<void> cancelBooking(String bookingId);
}

class BookingsRemoteDataSourceImpl implements BookingsRemoteDataSource {
  final SupabaseClient supabaseClient;

  BookingsRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    // 1. Get current balance
    final profile = await supabaseClient
        .from('profiles')
        .select('balance')
        .eq('id', user.id)
        .single();

    final currentBalance = (profile['balance'] ?? 0).toDouble();

    if (currentBalance < booking.totalPrice) {
      throw Exception('insufficient_balance');
    }

    // 2. Insert booking
    final response = await supabaseClient
        .from('bookings')
        .insert({
          ...booking.toJson(),
          'user_id': user.id, // Ensure user_id is set
        })
        .select()
        .single();

    final createdBooking = BookingModel.fromJson(response);

    // 3. Create transaction record
    await supabaseClient.from('wallet_transactions').insert({
      'user_id': user.id,
      'title': 'Car Wash Booking #${createdBooking.id.substring(0, 8)}',
      'amount': -booking.totalPrice,
      'type': 'booking',
      'created_at': DateTime.now().toIso8601String(),
    });

    // 4. Update user balance
    await supabaseClient
        .from('profiles')
        .update({
          'balance': currentBalance - booking.totalPrice,
          'last_transaction_at': DateTime.now().toIso8601String(),
        })
        .eq('id', user.id);

    return createdBooking;
  }

  @override
  Future<List<BookingModel>> getMyBookings() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) return [];

    final response = await supabaseClient
        .from('bookings')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);
    return (response as List)
        .map((json) => BookingModel.fromJson(json))
        .toList();
  }

  @override
  Future<BookingModel> getBookingStatus(String bookingId) async {
    final response = await supabaseClient
        .from('bookings')
        .select()
        .eq('id', bookingId)
        .single();
    return BookingModel.fromJson(response);
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    // 1. Get booking details to know the price
    final bookingResponse = await supabaseClient
        .from('bookings')
        .select()
        .eq('id', bookingId)
        .single();

    final price = (bookingResponse['total_price'] as num).toDouble();
    final status = bookingResponse['status'];

    if (status == 'cancelled') return; // Already cancelled

    // 2. Update booking status to cancelled
    await supabaseClient
        .from('bookings')
        .update({'status': 'cancelled'})
        .eq('id', bookingId);

    // 3. Create refund transaction
    await supabaseClient.from('wallet_transactions').insert({
      'user_id': user.id,
      'title': 'Refund: Booking #${bookingId.substring(0, 8)}',
      'amount': price, // Positive amount for refund
      'type': 'refund',
      'created_at': DateTime.now().toIso8601String(),
    });

    // 4. Update user balance
    final profile = await supabaseClient
        .from('profiles')
        .select('balance')
        .eq('id', user.id)
        .single();

    final newBalance = (profile['balance'] ?? 0) + price;

    await supabaseClient
        .from('profiles')
        .update({
          'balance': newBalance,
          'last_transaction_at': DateTime.now().toIso8601String(),
        })
        .eq('id', user.id);
  }
}

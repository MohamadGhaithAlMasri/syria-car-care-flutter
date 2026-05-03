import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booking_model.dart';

abstract class BookingsRemoteDataSource {
  Future<BookingModel> createBooking(BookingModel booking);
  Future<List<BookingModel>> getMyBookings();
  Future<BookingModel> getBookingStatus(String bookingId);
}

class BookingsRemoteDataSourceImpl implements BookingsRemoteDataSource {
  final SupabaseClient supabaseClient;

  BookingsRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    final response = await supabaseClient
        .from('bookings')
        .insert(booking.toJson())
        .select()
        .single();
    return BookingModel.fromJson(response);
  }

  @override
  Future<List<BookingModel>> getMyBookings() async {
    final response = await supabaseClient
        .from('bookings')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((json) => BookingModel.fromJson(json)).toList();
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
}

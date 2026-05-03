import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking.dart';

abstract class BookingsRepository {
  Future<Either<Failure, Booking>> createBooking(Booking booking);
  Future<Either<Failure, List<Booking>>> getMyBookings();
  Future<Either<Failure, Booking>> getBookingStatus(String bookingId);
}

import 'package:dartz/dartz.dart';
import 'package:syria_car_care2/features/services/domain/entities/booking.dart';
import 'package:syria_car_care2/features/services/domain/repositories/bookings_repository.dart';
import '../../../../core/error/failures.dart';
import '../datasources/bookings_remote_data_source.dart';
import '../models/booking_model.dart';

class BookingsRepositoryImpl implements BookingsRepository {
  final BookingsRemoteDataSource remoteDataSource;

  BookingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Booking>> createBooking(Booking booking) async {
    try {
      final model = BookingModel(
        id: booking.id,
        vehicleId: booking.vehicleId,
        serviceId: booking.serviceId,
        scheduledAt: booking.scheduledAt,
        status: booking.status,
        totalPrice: booking.totalPrice,
        latitude: booking.latitude,
        longitude: booking.longitude,
      );
      final result = await remoteDataSource.createBooking(model);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getMyBookings() async {
    try {
      final result = await remoteDataSource.getMyBookings();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Booking>> getBookingStatus(String bookingId) async {
    try {
      final result = await remoteDataSource.getBookingStatus(bookingId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

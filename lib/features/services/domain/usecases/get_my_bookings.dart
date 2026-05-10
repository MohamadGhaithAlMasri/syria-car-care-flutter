import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/booking.dart';
import '../repositories/bookings_repository.dart';

class GetMyBookings implements UseCase<List<Booking>, NoParams> {
  final BookingsRepository repository;

  GetMyBookings(this.repository);

  @override
  Future<Either<Failure, List<Booking>>> call(NoParams params) async {
    return await repository.getMyBookings();
  }
}

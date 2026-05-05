import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/bookings_repository.dart';

class CancelBooking implements UseCase<void, String> {
  final BookingsRepository repository;

  CancelBooking(this.repository);

  @override
  Future<Either<Failure, void>> call(String bookingId) async {
    return await repository.cancelBooking(bookingId);
  }
}

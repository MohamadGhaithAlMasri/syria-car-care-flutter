import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/bookings_repository.dart';

class UpdateBookingStatus implements UseCase<void, UpdateBookingStatusParams> {
  final BookingsRepository repository;

  UpdateBookingStatus(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateBookingStatusParams params) async {
    return await repository.updateBookingStatus(params.bookingId, params.status);
  }
}

class UpdateBookingStatusParams extends Equatable {
  final String bookingId;
  final String status;

  const UpdateBookingStatusParams({required this.bookingId, required this.status});

  @override
  List<Object?> get props => [bookingId, status];
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/vehicles_repository.dart';

class DeleteVehicle implements UseCase<void, String> {
  final VehiclesRepository repository;
  DeleteVehicle(this.repository);

  @override
  Future<Either<Failure, void>> call(String vehicleId) async {
    return await repository.deleteVehicle(vehicleId);
  }
}

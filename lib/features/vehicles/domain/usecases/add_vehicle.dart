import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vehicle.dart';
import '../repositories/vehicles_repository.dart';

class AddVehicle implements UseCase<void, Vehicle> {
  final VehiclesRepository repository;

  AddVehicle(this.repository);

  @override
  Future<Either<Failure, void>> call(Vehicle params) async {
    return await repository.addVehicle(params);
  }
}

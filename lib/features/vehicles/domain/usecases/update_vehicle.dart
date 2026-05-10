import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vehicle.dart';
import '../repositories/vehicles_repository.dart';

class UpdateVehicle {
  final VehiclesRepository repository;

  UpdateVehicle(this.repository);

  Future<Either<Failure, void>> call(Vehicle vehicle) async {
    return await repository.updateVehicle(vehicle);
  }
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vehicle.dart';

abstract class VehiclesRepository {
  Future<Either<Failure, List<Vehicle>>> getVehicles();
  Future<Either<Failure, void>> addVehicle(Vehicle vehicle);
  Future<Either<Failure, void>> deleteVehicle(String vehicleId);
  Future<Either<Failure, void>> updateVehicle(Vehicle vehicle);
}

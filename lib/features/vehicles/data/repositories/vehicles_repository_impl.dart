import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicles_repository.dart';
import '../datasources/vehicles_remote_data_source.dart';
import '../models/vehicle_model.dart';

class VehiclesRepositoryImpl implements VehiclesRepository {
  final VehiclesRemoteDataSource remoteDataSource;

  VehiclesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Vehicle>>> getVehicles() async {
    try {
      final vehicles = await remoteDataSource.getVehicles();
      return Right(vehicles);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addVehicle(Vehicle vehicle) async {
    try {
      await remoteDataSource.addVehicle(
        VehicleModel(
          id: vehicle.id,
          brand: vehicle.brand,
          model: vehicle.model,
          year: vehicle.year,
          plateNumber: vehicle.plateNumber,
          color: vehicle.color,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteVehicle(String vehicleId) async {
    try {
      await remoteDataSource.deleteVehicle(vehicleId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateVehicle(Vehicle vehicle) async {
    try {
      await remoteDataSource.updateVehicle(
        VehicleModel(
          id: vehicle.id,
          brand: vehicle.brand,
          model: vehicle.model,
          year: vehicle.year,
          plateNumber: vehicle.plateNumber,
          color: vehicle.color,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

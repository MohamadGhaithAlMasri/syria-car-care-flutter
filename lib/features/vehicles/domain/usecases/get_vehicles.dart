import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vehicle.dart';
import '../repositories/vehicles_repository.dart';

class GetVehicles implements UseCase<List<Vehicle>, NoParams> {
  final VehiclesRepository repository;
  GetVehicles(this.repository);

  @override
  Future<Either<Failure, List<Vehicle>>> call(NoParams params) async {
    return await repository.getVehicles();
  }
}

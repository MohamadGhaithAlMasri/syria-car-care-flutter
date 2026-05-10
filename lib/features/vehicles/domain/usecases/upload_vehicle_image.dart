import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/vehicles_repository.dart';

class UploadVehicleImage {
  final VehiclesRepository repository;

  UploadVehicleImage(this.repository);

  Future<Either<Failure, String>> call(dynamic file, String fileName) async {
    return await repository.uploadVehicleImage(file, fileName);
  }
}

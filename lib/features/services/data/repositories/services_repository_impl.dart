import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/service.dart';
import '../../domain/repositories/services_repository.dart';
import '../datasources/services_remote_data_source.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  final ServicesRemoteDataSource remoteDataSource;

  ServicesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Service>>> getServices() async {
    try {
      final services = await remoteDataSource.getServices();
      return Right(services);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

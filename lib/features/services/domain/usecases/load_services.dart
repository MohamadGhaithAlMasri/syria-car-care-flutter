import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/service.dart';
import '../repositories/services_repository.dart';

class LoadServices implements UseCase<List<Service>, NoParams> {
  final ServicesRepository repository;
  LoadServices(this.repository);

  @override
  Future<Either<Failure, List<Service>>> call(NoParams params) async {
    return await repository.getServices();
  }
}

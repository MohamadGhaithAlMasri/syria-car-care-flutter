import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_address.dart';
import '../repositories/account_repository.dart';

class SaveAddress implements UseCase<Unit, UserAddress> {
  final AccountRepository repository;

  SaveAddress(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UserAddress address) async {
    return await repository.saveAddress(address);
  }
}

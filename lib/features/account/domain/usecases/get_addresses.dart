import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_address.dart';
import '../repositories/account_repository.dart';

class GetAddresses implements UseCase<List<UserAddress>, NoParams> {
  final AccountRepository repository;

  GetAddresses(this.repository);

  @override
  Future<Either<Failure, List<UserAddress>>> call(NoParams params) async {
    return await repository.getAddresses();
  }
}

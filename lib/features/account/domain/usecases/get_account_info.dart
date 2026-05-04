import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/account_info.dart';
import '../repositories/account_repository.dart';

class GetAccountInfo {
  final AccountRepository repository;

  GetAccountInfo(this.repository);

  Future<Either<Failure, AccountInfo>> call() async {
    return await repository.getAccountInfo();
  }
}

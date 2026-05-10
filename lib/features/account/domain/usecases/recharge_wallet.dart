import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/account_repository.dart';

class RechargeWallet {
  final AccountRepository repository;

  RechargeWallet(this.repository);

  Future<Either<Failure, Unit>> call(double amount, String method) async {
    return await repository.rechargeWallet(amount, method);
  }
}

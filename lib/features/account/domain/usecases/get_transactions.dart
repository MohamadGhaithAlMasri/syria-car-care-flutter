import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/wallet_transaction.dart';
import '../repositories/account_repository.dart';

class GetTransactions {
  final AccountRepository repository;

  GetTransactions(this.repository);

  Future<Either<Failure, List<WalletTransaction>>> call() async {
    return await repository.getTransactions();
  }
}

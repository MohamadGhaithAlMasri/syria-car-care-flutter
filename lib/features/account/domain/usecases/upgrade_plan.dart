import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/account_repository.dart';

class UpgradePlan {
  final AccountRepository repository;

  UpgradePlan(this.repository);

  Future<Either<Failure, Unit>> call(String planName, double price) async {
    return await repository.upgradePlan(planName, price);
  }
}

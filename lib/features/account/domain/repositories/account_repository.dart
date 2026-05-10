import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/account_info.dart';
import '../entities/wallet_transaction.dart';
import '../entities/user_address.dart';

abstract class AccountRepository {
  Future<Either<Failure, AccountInfo>> getAccountInfo();
  Future<Either<Failure, List<WalletTransaction>>> getTransactions();
  Future<Either<Failure, Unit>> rechargeWallet(double amount, String method);
  Future<Either<Failure, Unit>> upgradePlan(String planName, double price);
  Future<Either<Failure, String>> uploadAvatar(String filePath);
  Future<Either<Failure, List<UserAddress>>> getAddresses();
  Future<Either<Failure, Unit>> saveAddress(UserAddress address);
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/account_info.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../../domain/entities/user_address.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_remote_data_source.dart';
import '../models/user_address_model.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;

  AccountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AccountInfo>> getAccountInfo() async {
    try {
      final accountInfo = await remoteDataSource.getAccountInfo();
      return Right(accountInfo);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WalletTransaction>>> getTransactions() async {
    try {
      final transactions = await remoteDataSource.getTransactions();
      return Right(transactions);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> rechargeWallet(double amount, String method) async {
    try {
      await remoteDataSource.rechargeWallet(amount, method);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> upgradePlan(String planName, double price) async {
    try {
      await remoteDataSource.upgradePlan(planName, price);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadAvatar(String filePath) async {
    try {
      final url = await remoteDataSource.uploadAvatar(filePath);
      return Right(url);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserAddress>>> getAddresses() async {
    try {
      final List<UserAddressModel> models = await remoteDataSource.getAddresses();
      // Explicitly convert to List<UserAddress> to avoid runtime type issues
      final List<UserAddress> entities = models.map((model) => model as UserAddress).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveAddress(UserAddress address) async {
    try {
      await remoteDataSource.saveAddress(UserAddressModel(
        id: address.id,
        userId: address.userId,
        type: address.type,
        latitude: address.latitude,
        longitude: address.longitude,
        addressName: address.addressName,
      ));
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

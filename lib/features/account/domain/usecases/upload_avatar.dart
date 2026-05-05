import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/account_repository.dart';

class UploadAvatar implements UseCase<String, String> {
  final AccountRepository repository;

  UploadAvatar(this.repository);

  @override
  Future<Either<Failure, String>> call(String filePath) async {
    return await repository.uploadAvatar(filePath);
  }
}

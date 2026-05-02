import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword(String email, String password, String name);
  Future<Either<Failure, User>> signInWithEmailPassword(String email, String password);
}

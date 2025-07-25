import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> sendSmsCode(String phone);
  Future<Either<Failure, User>> verifyCode(String phone, String code);
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> updateUser(User user);
}

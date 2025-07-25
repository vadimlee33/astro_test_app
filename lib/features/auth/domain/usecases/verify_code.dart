import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class VerifyCodeParams {
  final String phone;
  final String code;

  VerifyCodeParams({required this.phone, required this.code});
}

class VerifyCode implements UseCase<User, VerifyCodeParams> {
  final AuthRepository repository;

  VerifyCode(this.repository);

  @override
  Future<Either<Failure, User>> call(VerifyCodeParams params) {
    return repository.verifyCode(params.phone, params.code);
  }
}

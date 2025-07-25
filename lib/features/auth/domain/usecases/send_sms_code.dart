import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class SendSmsCode implements UseCase<void, String> {
  final AuthRepository repository;

  SendSmsCode(this.repository);

  @override
  Future<Either<Failure, void>> call(String phone) {
    return repository.sendSmsCode(phone);
  }
}

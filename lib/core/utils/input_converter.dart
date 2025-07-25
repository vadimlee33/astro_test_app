import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import '../constants/app_constants.dart';

class InputConverter {
  Either<Failure, String> validatePhone(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanPhone.isEmpty) {
      return const Left(ValidationFailure('Введите номер телефона'));
    }

    if (cleanPhone.length != AppConstants.phoneLength) {
      return const Left(ValidationFailure(
          'Номер телефона должен содержать ровно ${AppConstants.phoneLength} цифр'));
    }

    if (!cleanPhone.startsWith('7')) {
      return const Left(
          ValidationFailure('Номер телефона должен начинаться с 7'));
    }

    return Right(cleanPhone);
  }

  Either<Failure, String> validateSmsCode(String code) {
    final cleanCode = code.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanCode.isEmpty) {
      return const Left(ValidationFailure('SMS code cannot be empty'));
    }

    if (cleanCode.length != AppConstants.smsCodeLength) {
      return const Left(ValidationFailure(
          'Смс код должен содержать ровно ${AppConstants.smsCodeLength} цифр'));
    }

    return Right(cleanCode);
  }

  String formatPhoneNumber(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanPhone.length == AppConstants.phoneLength &&
        cleanPhone.startsWith('7')) {
      return '+$cleanPhone';
    }

    if (cleanPhone.length == 10) {
      return '+7$cleanPhone';
    }

    return cleanPhone;
  }

  String formatPhoneForDisplay(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanPhone.length == AppConstants.phoneLength &&
        cleanPhone.startsWith('7')) {
      return '${cleanPhone[0]} ${cleanPhone.substring(1, 4)} ${cleanPhone.substring(4, 7)} ${cleanPhone.substring(7, 9)} ${cleanPhone.substring(9)}';
    }

    return phone;
  }
}

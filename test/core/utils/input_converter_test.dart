import 'package:flutter_test/flutter_test.dart';
import 'package:astro_test_app/core/utils/input_converter.dart';
import 'package:astro_test_app/core/errors/failures.dart';

void main() {
  group('InputConverter - Phone Validation', () {
    late InputConverter inputConverter;

    setUp(() {
      inputConverter = InputConverter();
    });

    group('validatePhone', () {
      test('should return valid phone number when input is correct', () {
        // Arrange
        const phone = '79054132518';

        // Act
        final result = inputConverter.validatePhone(phone);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (validPhone) => expect(validPhone, '79054132518'),
        );
      });

      test(
          'should return valid phone number when input contains spaces and dashes',
          () {
        // Arrange
        const phone = '7 905 413-25-18';

        // Act
        final result = inputConverter.validatePhone(phone);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (validPhone) => expect(validPhone, '79054132518'),
        );
      });

      test('should return ValidationFailure when phone is empty', () {
        // Arrange
        const phone = '';

        // Act
        final result = inputConverter.validatePhone(phone);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Введите номер телефона');
          },
          (validPhone) => fail('Should return failure'),
        );
      });

      test(
          'should return ValidationFailure when phone contains only non-digits',
          () {
        // Arrange
        const phone = 'abc def ghi';

        // Act
        final result = inputConverter.validatePhone(phone);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Введите номер телефона');
          },
          (validPhone) => fail('Should return failure'),
        );
      });

      test('should return ValidationFailure when phone length is less than 11',
          () {
        // Arrange
        const phone = '7905413251';

        // Act
        final result = inputConverter.validatePhone(phone);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message,
                'Номер телефона должен содержать ровно 11 цифр');
          },
          (validPhone) => fail('Should return failure'),
        );
      });

      test('should return ValidationFailure when phone length is more than 11',
          () {
        // Arrange
        const phone = '790541325189';

        // Act
        final result = inputConverter.validatePhone(phone);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message,
                'Номер телефона должен содержать ровно 11 цифр');
          },
          (validPhone) => fail('Should return failure'),
        );
      });

      test('should return ValidationFailure when phone does not start with 7',
          () {
        // Arrange
        const phone = '89054132518';

        // Act
        final result = inputConverter.validatePhone(phone);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Номер телефона должен начинаться с 7');
          },
          (validPhone) => fail('Should return failure'),
        );
      });

      test(
          'should return ValidationFailure when phone starts with 8 but has correct length',
          () {
        // Arrange
        const phone = '89054132518';

        // Act
        final result = inputConverter.validatePhone(phone);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Номер телефона должен начинаться с 7');
          },
          (validPhone) => fail('Should return failure'),
        );
      });

      test(
          'should return ValidationFailure when phone starts with 8 and has wrong length',
          () {
        // Arrange
        const phone = '8905413251';

        // Act
        final result = inputConverter.validatePhone(phone);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message,
                'Номер телефона должен содержать ровно 11 цифр');
          },
          (validPhone) => fail('Should return failure'),
        );
      });
    });

    group('formatPhoneNumber', () {
      test('should format phone number with + prefix when valid', () {
        // Arrange
        const phone = '79054132518';

        // Act
        final result = inputConverter.formatPhoneNumber(phone);

        // Assert
        expect(result, '+79054132518');
      });

      test('should add 7 prefix when phone has 10 digits', () {
        // Arrange
        const phone = '9054132518';

        // Act
        final result = inputConverter.formatPhoneNumber(phone);

        // Assert
        expect(result, '+79054132518');
      });

      test('should return original input when phone is invalid', () {
        // Arrange
        const phone = '12345';

        // Act
        final result = inputConverter.formatPhoneNumber(phone);

        // Assert
        expect(result, '12345');
      });
    });

    group('formatPhoneForDisplay', () {
      test('should format phone number for display with spaces', () {
        // Arrange
        const phone = '79054132518';

        // Act
        final result = inputConverter.formatPhoneForDisplay(phone);

        // Assert
        expect(result, '7 905 413 25 18');
      });

      test('should return original input when phone is invalid', () {
        // Arrange
        const phone = '12345';

        // Act
        final result = inputConverter.formatPhoneForDisplay(phone);

        // Assert
        expect(result, '12345');
      });
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:astro_test_app/core/utils/input_converter.dart';
import 'package:astro_test_app/core/errors/failures.dart';

void main() {
  group('InputConverter - SMS Code Validation', () {
    late InputConverter inputConverter;

    setUp(() {
      inputConverter = InputConverter();
    });

    group('validateSmsCode', () {
      test('should return valid SMS code when input is correct', () {
        // Arrange
        const code = '123456';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (validCode) => expect(validCode, '123456'),
        );
      });

      test('should return valid SMS code when input contains spaces', () {
        // Arrange
        const code = '123 456';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (validCode) => expect(validCode, '123456'),
        );
      });

      test('should return valid SMS code when input contains dashes', () {
        // Arrange
        const code = '123-456';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (validCode) => expect(validCode, '123456'),
        );
      });

      test('should return ValidationFailure when SMS code is empty', () {
        // Arrange
        const code = '';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'SMS code cannot be empty');
          },
          (validCode) => fail('Should return failure'),
        );
      });

      test(
          'should return ValidationFailure when SMS code contains only non-digits',
          () {
        // Arrange
        const code = 'abcdef';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'SMS code cannot be empty');
          },
          (validCode) => fail('Should return failure'),
        );
      });

      test(
          'should return ValidationFailure when SMS code length is less than 6',
          () {
        // Arrange
        const code = '12345';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Смс код должен содержать ровно 6 цифр');
          },
          (validCode) => fail('Should return failure'),
        );
      });

      test(
          'should return ValidationFailure when SMS code length is more than 6',
          () {
        // Arrange
        const code = '1234567';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Смс код должен содержать ровно 6 цифр');
          },
          (validCode) => fail('Should return failure'),
        );
      });

      test(
          'should return ValidationFailure when SMS code contains letters and digits',
          () {
        // Arrange
        const code = '12a456';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Смс код должен содержать ровно 6 цифр');
          },
          (validCode) => fail('Should return failure'),
        );
      });

      test('should handle SMS code with mixed separators', () {
        // Arrange
        const code = '123 45-6';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (validCode) => expect(validCode, '123456'),
        );
      });

      test('should handle SMS code with leading zeros', () {
        // Arrange
        const code = '000123';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (validCode) => expect(validCode, '000123'),
        );
      });

      test('should handle SMS code with all zeros', () {
        // Arrange
        const code = '000000';

        // Act
        final result = inputConverter.validateSmsCode(code);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (validCode) => expect(validCode, '000000'),
        );
      });
    });
  });
}

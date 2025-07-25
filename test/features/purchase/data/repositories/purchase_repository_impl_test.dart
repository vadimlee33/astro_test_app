import 'package:flutter_test/flutter_test.dart';
import 'package:astro_test_app/features/purchase/data/repositories/purchase_repository_impl.dart';
import 'package:astro_test_app/features/purchase/domain/entities/purchase_entity.dart';

void main() {
  group('PurchaseRepositoryImpl', () {
    late PurchaseRepositoryImpl repository;

    setUp(() {
      repository = PurchaseRepositoryImpl();
    });

    group('getPurchaseOptions', () {
      test('should return list of purchase options', () async {
        // Act
        final result = await repository.getPurchaseOptions();

        // Assert
        expect(result, isA<List<PurchaseEntity>>());
        expect(result.length, 4);

        // Check first option
        expect(result[0].amount, 10);
        expect(result[0].title, 'Купить 10 звезд');

        // Check second option
        expect(result[1].amount, 20);
        expect(result[1].title, 'Купить 20 звезд');

        // Check third option
        expect(result[2].amount, 50);
        expect(result[2].title, 'Купить 50 звезд');

        // Check fourth option
        expect(result[3].amount, 100);
        expect(result[3].title, 'Купить 100 звезд');
      });

      test('should return options in correct order', () async {
        // Act
        final result = await repository.getPurchaseOptions();

        // Assert
        expect(result[0].amount, lessThan(result[1].amount));
        expect(result[1].amount, lessThan(result[2].amount));
        expect(result[2].amount, lessThan(result[3].amount));
      });

      test('should complete within reasonable time', () async {
        // Act & Assert
        final stopwatch = Stopwatch()..start();
        await repository.getPurchaseOptions();
        stopwatch.stop();

        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
      });
    });

    group('makePurchase', () {
      test('should complete successfully for valid purchase', () async {
        // Arrange
        const purchase = PurchaseEntity(
          amount: 50,
          title: 'Купить 50 звезд',
        );

        // Act & Assert
        expect(() async => await repository.makePurchase(purchase),
            returnsNormally);
      });

      test('should handle different purchase amounts', () async {
        // Arrange
        const purchases = [
          PurchaseEntity(amount: 10, title: 'Купить 10 звезд'),
          PurchaseEntity(amount: 20, title: 'Купить 20 звезд'),
          PurchaseEntity(amount: 50, title: 'Купить 50 звезд'),
          PurchaseEntity(amount: 100, title: 'Купить 100 звезд'),
        ];

        // Act & Assert
        for (final purchase in purchases) {
          expect(() async => await repository.makePurchase(purchase),
              returnsNormally);
        }
      });

      test('should complete within reasonable time', () async {
        // Arrange
        const purchase = PurchaseEntity(
          amount: 25,
          title: 'Купить 25 звезд',
        );

        // Act & Assert
        final stopwatch = Stopwatch()..start();
        await repository.makePurchase(purchase);
        stopwatch.stop();

        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
      });

      test('should handle zero amount purchase', () async {
        // Arrange
        const purchase = PurchaseEntity(
          amount: 0,
          title: 'Купить 0 звезд',
        );

        // Act & Assert
        expect(() async => await repository.makePurchase(purchase),
            returnsNormally);
      });

      test('should handle negative amount purchase', () async {
        // Arrange
        const purchase = PurchaseEntity(
          amount: -10,
          title: 'Купить -10 звезд',
        );

        // Act & Assert
        expect(() async => await repository.makePurchase(purchase),
            returnsNormally);
      });
    });
  });
}

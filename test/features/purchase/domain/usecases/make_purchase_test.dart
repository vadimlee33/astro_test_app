import 'package:flutter_test/flutter_test.dart';
import 'package:astro_test_app/features/purchase/domain/usecases/make_purchase.dart';
import 'package:astro_test_app/features/purchase/domain/entities/purchase_entity.dart';

void main() {
  group('ExecutePurchase', () {
    late ExecutePurchase executePurchase;
    late int balanceIncrement;

    setUp(() {
      balanceIncrement = 0;
      executePurchase = ExecutePurchase((amount) {
        balanceIncrement += amount;
      });
    });

    test('should increment balance with correct amount', () async {
      // Arrange
      const purchase = PurchaseEntity(
        amount: 50,
        title: 'Купить 50 звезд',
      );

      // Act
      await executePurchase(purchase);

      // Assert
      expect(balanceIncrement, 50);
    });

    test('should handle multiple purchases correctly', () async {
      // Arrange
      const purchase1 = PurchaseEntity(
        amount: 10,
        title: 'Купить 10 звезд',
      );
      const purchase2 = PurchaseEntity(
        amount: 20,
        title: 'Купить 20 звезд',
      );
      const purchase3 = PurchaseEntity(
        amount: 100,
        title: 'Купить 100 звезд',
      );

      // Act
      await executePurchase(purchase1);
      await executePurchase(purchase2);
      await executePurchase(purchase3);

      // Assert
      expect(balanceIncrement, 130);
    });

    test('should handle zero amount purchase', () async {
      // Arrange
      const purchase = PurchaseEntity(
        amount: 0,
        title: 'Купить 0 звезд',
      );

      // Act
      await executePurchase(purchase);

      // Assert
      expect(balanceIncrement, 0);
    });

    test('should handle negative amount purchase', () async {
      // Arrange
      const purchase = PurchaseEntity(
        amount: -10,
        title: 'Купить -10 звезд',
      );

      // Act
      await executePurchase(purchase);

      // Assert
      expect(balanceIncrement, -10);
    });

    test('should complete successfully without throwing exceptions', () async {
      // Arrange
      const purchase = PurchaseEntity(
        amount: 25,
        title: 'Купить 25 звезд',
      );

      // Act & Assert
      expect(() async => await executePurchase(purchase), returnsNormally);
    });
  });
}

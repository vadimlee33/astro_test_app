import 'package:flutter_test/flutter_test.dart';
import 'package:astro_test_app/features/purchase/domain/entities/purchase_entity.dart';

void main() {
  group('PurchaseEntity', () {
    test('should create PurchaseEntity with correct values', () {
      // Arrange & Act
      const purchase = PurchaseEntity(
        amount: 50,
        title: 'Купить 50 звезд',
      );

      // Assert
      expect(purchase.amount, 50);
      expect(purchase.title, 'Купить 50 звезд');
    });

    test('should be equal when properties are the same', () {
      // Arrange
      const purchase1 = PurchaseEntity(
        amount: 50,
        title: 'Купить 50 звезд',
      );
      const purchase2 = PurchaseEntity(
        amount: 50,
        title: 'Купить 50 звезд',
      );

      // Act & Assert
      expect(purchase1, equals(purchase2));
      expect(purchase1.hashCode, equals(purchase2.hashCode));
    });

    test('should not be equal when amount is different', () {
      // Arrange
      const purchase1 = PurchaseEntity(
        amount: 50,
        title: 'Купить 50 звезд',
      );
      const purchase2 = PurchaseEntity(
        amount: 100,
        title: 'Купить 50 звезд',
      );

      // Act & Assert
      expect(purchase1, isNot(equals(purchase2)));
    });

    test('should not be equal when title is different', () {
      // Arrange
      const purchase1 = PurchaseEntity(
        amount: 50,
        title: 'Купить 50 звезд',
      );
      const purchase2 = PurchaseEntity(
        amount: 50,
        title: 'Купить 100 звезд',
      );

      // Act & Assert
      expect(purchase1, isNot(equals(purchase2)));
    });

    test('should handle zero amount', () {
      // Arrange & Act
      const purchase = PurchaseEntity(
        amount: 0,
        title: 'Купить 0 звезд',
      );

      // Assert
      expect(purchase.amount, 0);
      expect(purchase.title, 'Купить 0 звезд');
    });

    test('should handle negative amount', () {
      // Arrange & Act
      const purchase = PurchaseEntity(
        amount: -10,
        title: 'Купить -10 звезд',
      );

      // Assert
      expect(purchase.amount, -10);
      expect(purchase.title, 'Купить -10 звезд');
    });

    test('should handle empty title', () {
      // Arrange & Act
      const purchase = PurchaseEntity(
        amount: 25,
        title: '',
      );

      // Assert
      expect(purchase.amount, 25);
      expect(purchase.title, '');
    });

    test('should handle large amount', () {
      // Arrange & Act
      const purchase = PurchaseEntity(
        amount: 999999,
        title: 'Купить 999999 звезд',
      );

      // Assert
      expect(purchase.amount, 999999);
      expect(purchase.title, 'Купить 999999 звезд');
    });

    test('should have correct props list', () {
      // Arrange
      const purchase = PurchaseEntity(
        amount: 50,
        title: 'Купить 50 звезд',
      );

      // Act
      final props = purchase.props;

      // Assert
      expect(props, [50, 'Купить 50 звезд']);
      expect(props.length, 2);
    });

    test('should handle special characters in title', () {
      // Arrange & Act
      const purchase = PurchaseEntity(
        amount: 25,
        title: 'Купить 25 звезд!',
      );

      // Assert
      expect(purchase.amount, 25);
      expect(purchase.title, 'Купить 25 звезд!');
    });
  });
}

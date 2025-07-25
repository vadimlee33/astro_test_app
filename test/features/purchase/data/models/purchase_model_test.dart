import 'package:flutter_test/flutter_test.dart';
import 'package:astro_test_app/features/purchase/data/models/purchase_model.dart';

void main() {
  group('PurchaseModel', () {
    test('should create PurchaseModel with correct values', () {
      // Arrange & Act
      const model = PurchaseModel(
        amount: 50,
        title: 'Купить 50 звезд',
      );

      // Assert
      expect(model.amount, 50);
      expect(model.title, 'Купить 50 звезд');
    });

    test('should create PurchaseModel from JSON', () {
      // Arrange
      const json = {
        'amount': 100,
        'title': 'Купить 100 звезд',
      };

      // Act
      final model = PurchaseModel.fromJson(json);

      // Assert
      expect(model.amount, 100);
      expect(model.title, 'Купить 100 звезд');
    });

    test('should convert PurchaseModel to JSON', () {
      // Arrange
      const model = PurchaseModel(
        amount: 25,
        title: 'Купить 25 звезд',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json, {
        'amount': 25,
        'title': 'Купить 25 звезд',
      });
    });

    test('should handle zero amount in JSON conversion', () {
      // Arrange
      const model = PurchaseModel(
        amount: 0,
        title: 'Купить 0 звезд',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json, {
        'amount': 0,
        'title': 'Купить 0 звезд',
      });
    });

    test('should handle negative amount in JSON conversion', () {
      // Arrange
      const model = PurchaseModel(
        amount: -10,
        title: 'Купить -10 звезд',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json, {
        'amount': -10,
        'title': 'Купить -10 звезд',
      });
    });

    test('should handle empty title in JSON conversion', () {
      // Arrange
      const model = PurchaseModel(
        amount: 50,
        title: '',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json, {
        'amount': 50,
        'title': '',
      });
    });

    test('should handle large amount in JSON conversion', () {
      // Arrange
      const model = PurchaseModel(
        amount: 999999,
        title: 'Купить 999999 звезд',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json, {
        'amount': 999999,
        'title': 'Купить 999999 звезд',
      });
    });

    test('should be equal when properties are the same', () {
      // Arrange
      const model1 = PurchaseModel(
        amount: 50,
        title: 'Купить 50 звезд',
      );
      const model2 = PurchaseModel(
        amount: 50,
        title: 'Купить 50 звезд',
      );

      // Act & Assert
      expect(model1, equals(model2));
      expect(model1.hashCode, equals(model2.hashCode));
    });

    test('should not be equal when amount is different', () {
      // Arrange
      const model1 = PurchaseModel(
        amount: 50,
        title: 'Купить 50 звезд',
      );
      const model2 = PurchaseModel(
        amount: 100,
        title: 'Купить 50 звезд',
      );

      // Act & Assert
      expect(model1, isNot(equals(model2)));
    });

    test('should not be equal when title is different', () {
      // Arrange
      const model1 = PurchaseModel(
        amount: 50,
        title: 'Купить 50 звезд',
      );
      const model2 = PurchaseModel(
        amount: 50,
        title: 'Купить 100 звезд',
      );

      // Act & Assert
      expect(model1, isNot(equals(model2)));
    });

    test('should have correct props list', () {
      // Arrange
      const model = PurchaseModel(
        amount: 50,
        title: 'Купить 50 звезд',
      );

      // Act
      final props = model.props;

      // Assert
      expect(props, [50, 'Купить 50 звезд']);
      expect(props.length, 2);
    });
  });
}

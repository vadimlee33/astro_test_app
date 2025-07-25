import 'package:flutter_test/flutter_test.dart';
import 'package:astro_test_app/features/purchase/presentation/bloc/purchase_bloc.dart';
import 'package:astro_test_app/features/purchase/presentation/bloc/purchase_event.dart';
import 'package:astro_test_app/features/purchase/presentation/bloc/purchase_state.dart';
import 'package:astro_test_app/features/purchase/domain/repositories/purchase_repository.dart';
import 'package:astro_test_app/features/purchase/domain/usecases/make_purchase.dart';
import 'package:astro_test_app/features/purchase/domain/entities/purchase_entity.dart';

class MockPurchaseRepository implements PurchaseRepository {
  List<PurchaseEntity>? _returnOptions;
  Exception? _throwException;
  bool _makePurchaseCalled = false;

  void setReturnOptions(List<PurchaseEntity> options) {
    _returnOptions = options;
  }

  void setThrowException(Exception exception) {
    _throwException = exception;
  }

  bool get makePurchaseCalled => _makePurchaseCalled;

  @override
  Future<List<PurchaseEntity>> getPurchaseOptions() async {
    if (_throwException != null) {
      throw _throwException!;
    }
    return _returnOptions ??
        [
          const PurchaseEntity(amount: 10, title: 'Купить 10 звезд'),
          const PurchaseEntity(amount: 20, title: 'Купить 20 звезд'),
          const PurchaseEntity(amount: 50, title: 'Купить 50 звезд'),
          const PurchaseEntity(amount: 100, title: 'Купить 100 звезд'),
        ];
  }

  @override
  Future<void> makePurchase(PurchaseEntity purchase) async {
    _makePurchaseCalled = true;
    if (_throwException != null) {
      throw _throwException!;
    }
  }
}

class MockExecutePurchase implements ExecutePurchase {
  bool _called = false;
  Exception? _throwException;
  final Function(int amount) _incrementBalance = (amount) {};

  void setThrowException(Exception exception) {
    _throwException = exception;
  }

  bool get called => _called;

  @override
  Function(int amount) get incrementBalance => _incrementBalance;

  @override
  Future<void> call(PurchaseEntity purchase) async {
    _called = true;
    if (_throwException != null) {
      throw _throwException!;
    }
  }
}

void main() {
  group('PurchaseBloc', () {
    late PurchaseBloc bloc;
    late MockPurchaseRepository mockRepository;
    late MockExecutePurchase mockExecutePurchase;

    setUp(() {
      mockRepository = MockPurchaseRepository();
      mockExecutePurchase = MockExecutePurchase();
      bloc = PurchaseBloc(
        repository: mockRepository,
        executePurchase: mockExecutePurchase,
      );
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state should be PurchaseInitial', () {
      expect(bloc.state, isA<PurchaseInitial>());
    });

    group('LoadPurchaseOptions', () {
      test('should emit PurchaseLoading then PurchaseOptionsLoaded on success',
          () async {
        // Arrange
        final testOptions = [
          const PurchaseEntity(amount: 10, title: 'Купить 10 звезд'),
          const PurchaseEntity(amount: 20, title: 'Купить 20 звезд'),
        ];
        mockRepository.setReturnOptions(testOptions);

        // Act
        bloc.add(LoadPurchaseOptions());

        // Assert
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<PurchaseLoading>(),
            isA<PurchaseOptionsLoaded>(),
          ]),
        );
      });

      test('should emit PurchaseLoading then PurchaseError on failure',
          () async {
        // Arrange
        mockRepository.setThrowException(Exception('Network error'));

        // Act
        bloc.add(LoadPurchaseOptions());

        // Assert
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<PurchaseLoading>(),
            isA<PurchaseError>(),
          ]),
        );
      });
    });

    group('MakePurchase', () {
      test('should emit PurchaseSuccess on successful purchase', () async {
        // Arrange
        final testPurchase = const PurchaseEntity(
          amount: 50,
          title: 'Купить 50 звезд',
        );

        // Act
        bloc.add(MakePurchase(testPurchase));

        // Assert
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<PurchaseSuccess>(),
          ]),
        );
      });

      test('should emit PurchaseError on failed purchase', () async {
        // Arrange
        final testPurchase = const PurchaseEntity(
          amount: 50,
          title: 'Купить 50 звезд',
        );
        mockExecutePurchase.setThrowException(Exception('Purchase failed'));

        // Act
        bloc.add(MakePurchase(testPurchase));

        // Assert
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<PurchaseError>(),
          ]),
        );
      });

      test('PurchaseSuccess should contain correct purchase data', () async {
        // Arrange
        final testPurchase = const PurchaseEntity(
          amount: 50,
          title: 'Купить 50 звезд',
        );

        // Act
        bloc.add(MakePurchase(testPurchase));
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<PurchaseSuccess>(),
          ]),
        );

        // Assert
        final state = bloc.state as PurchaseSuccess;
        expect(state.purchase, equals(testPurchase));
      });

      test('PurchaseError should contain error message', () async {
        // Arrange
        final testPurchase = const PurchaseEntity(
          amount: 50,
          title: 'Купить 50 звезд',
        );
        mockExecutePurchase.setThrowException(Exception('Purchase failed'));

        // Act
        bloc.add(MakePurchase(testPurchase));
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<PurchaseError>(),
          ]),
        );

        // Assert
        final state = bloc.state as PurchaseError;
        expect(state.message, equals('Ошибка при совершении покупки'));
      });
    });
  });
}

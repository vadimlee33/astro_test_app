import '../../domain/entities/purchase_entity.dart';
import '../../domain/repositories/purchase_repository.dart';
import '../models/purchase_model.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  @override
  Future<List<PurchaseEntity>> getPurchaseOptions() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const PurchaseModel(
        amount: 10,
        title: 'Купить 10 звезд',
      ),
      const PurchaseModel(
        amount: 20,
        title: 'Купить 20 звезд',
      ),
      const PurchaseModel(
        amount: 50,
        title: 'Купить 50 звезд',
      ),
      const PurchaseModel(
        amount: 100,
        title: 'Купить 100 звезд',
      ),
    ];
  }

  @override
  Future<void> makePurchase(PurchaseEntity purchase) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

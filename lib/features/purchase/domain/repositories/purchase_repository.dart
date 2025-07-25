import '../entities/purchase_entity.dart';

abstract class PurchaseRepository {
  Future<List<PurchaseEntity>> getPurchaseOptions();
  Future<void> makePurchase(PurchaseEntity purchase);
} 
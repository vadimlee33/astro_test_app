import '../entities/purchase_entity.dart';

class ExecutePurchase {
  final Function(int amount) incrementBalance;

  ExecutePurchase(this.incrementBalance);

  Future<void> call(PurchaseEntity purchase) async {
    incrementBalance(purchase.amount);
  }
}

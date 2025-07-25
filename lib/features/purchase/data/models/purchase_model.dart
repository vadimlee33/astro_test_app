import '../../domain/entities/purchase_entity.dart';

class PurchaseModel extends PurchaseEntity {
  const PurchaseModel({
    required super.amount,
    required super.title,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      amount: json['amount'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'title': title,
    };
  }
}

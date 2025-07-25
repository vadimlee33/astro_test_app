import 'package:equatable/equatable.dart';

class PurchaseEntity extends Equatable {
  final int amount;
  final String title;

  const PurchaseEntity({
    required this.amount,
    required this.title,
  });

  @override
  List<Object> get props => [amount, title];
}

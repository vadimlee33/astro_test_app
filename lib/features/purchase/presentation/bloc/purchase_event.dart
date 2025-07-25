import 'package:equatable/equatable.dart';
import '../../domain/entities/purchase_entity.dart';

abstract class PurchaseEvent extends Equatable {
  const PurchaseEvent();

  @override
  List<Object> get props => [];
}

class LoadPurchaseOptions extends PurchaseEvent {}

class MakePurchase extends PurchaseEvent {
  final PurchaseEntity purchase;

  const MakePurchase(this.purchase);

  @override
  List<Object> get props => [purchase];
} 
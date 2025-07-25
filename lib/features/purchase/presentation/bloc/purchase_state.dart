import 'package:equatable/equatable.dart';
import '../../domain/entities/purchase_entity.dart';

abstract class PurchaseState extends Equatable {
  const PurchaseState();

  @override
  List<Object> get props => [];
}

class PurchaseInitial extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}

class PurchaseOptionsLoaded extends PurchaseState {
  final List<PurchaseEntity> options;

  const PurchaseOptionsLoaded(this.options);

  @override
  List<Object> get props => [options];
}

class PurchaseSuccess extends PurchaseState {
  final PurchaseEntity purchase;

  const PurchaseSuccess(this.purchase);

  @override
  List<Object> get props => [purchase];
}

class PurchaseError extends PurchaseState {
  final String message;

  const PurchaseError(this.message);

  @override
  List<Object> get props => [message];
}

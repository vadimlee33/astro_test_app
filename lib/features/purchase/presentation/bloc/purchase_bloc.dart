import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/purchase_repository.dart';
import '../../domain/usecases/make_purchase.dart';
import 'purchase_event.dart';
import 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final PurchaseRepository repository;
  final ExecutePurchase executePurchase;

  PurchaseBloc({
    required this.repository,
    required this.executePurchase,
  }) : super(PurchaseInitial()) {
    on<LoadPurchaseOptions>(_onLoadPurchaseOptions);
    on<MakePurchase>(_onMakePurchase);
  }

  Future<void> _onLoadPurchaseOptions(
    LoadPurchaseOptions event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(PurchaseLoading());
    try {
      final options = await repository.getPurchaseOptions();
      emit(PurchaseOptionsLoaded(options));
    } catch (e) {
      emit(const PurchaseError('Не удалось загрузить опции покупки'));
    }
  }

  Future<void> _onMakePurchase(
    MakePurchase event,
    Emitter<PurchaseState> emit,
  ) async {
    try {
      await executePurchase(event.purchase);
      emit(PurchaseSuccess(event.purchase));
    } catch (e) {
      emit(const PurchaseError('Ошибка при совершении покупки'));
    }
  }
}

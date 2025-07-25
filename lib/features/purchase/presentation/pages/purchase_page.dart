import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui_kit/app_box.dart';
import '../bloc/purchase_bloc.dart';
import '../bloc/purchase_event.dart';
import '../bloc/purchase_state.dart';
import '../widgets/purchase_button.dart';
import '../../domain/entities/purchase_entity.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  List<PurchaseEntity> _purchaseOptions = [];

  @override
  void initState() {
    super.initState();
    context.read<PurchaseBloc>().add(LoadPurchaseOptions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Покупка звезд'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<PurchaseBloc, PurchaseState>(
        listener: (context, state) {
          if (state is PurchaseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Успешно куплено ${state.purchase.amount} звезд!'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is PurchaseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PurchaseLoading && _purchaseOptions.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PurchaseOptionsLoaded) {
            _purchaseOptions = state.options;
            return _buildPurchaseOptions();
          } else if (state is PurchaseError && _purchaseOptions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const HBox(16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const HBox(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PurchaseBloc>().add(LoadPurchaseOptions());
                    },
                    child: const Text('Попробовать снова'),
                  ),
                ],
              ),
            );
          }

          // По умолчанию показываем список товаров
          return _buildPurchaseOptions();
        },
      ),
    );
  }

  Widget _buildPurchaseOptions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Удерживайте кнопку 2 секунды для покупки:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const HBox(24),
          ..._purchaseOptions.map((purchase) {
            return PurchaseButton(
              purchase: purchase,
              isLoading: false,
              onPressed: () {
                context.read<PurchaseBloc>().add(MakePurchase(purchase));
              },
            );
          }),
        ],
      ),
    );
  }
}

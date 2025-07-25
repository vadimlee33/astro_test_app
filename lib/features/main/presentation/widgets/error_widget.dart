import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/ui_kit/app_box.dart';

class MainErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const MainErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
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
            message,
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const HBox(16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Попробовать снова'),
          ),
        ],
      ),
    );
  }
}

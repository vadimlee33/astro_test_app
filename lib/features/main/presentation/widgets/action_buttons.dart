import 'package:flutter/material.dart';
import '../../../../core/theme/color_schemes.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback? onPurchasePressed;
  final VoidCallback? onNotificationPressed;

  const ActionButtons({
    super.key,
    required this.onPurchasePressed,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onPurchasePressed,
            icon: const Icon(Icons.star),
            label: const Text(
              'Купить звезды',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorSchemes.lightColorScheme.primary,
              foregroundColor: AppColorSchemes.lightColorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onNotificationPressed,
            icon: const Icon(Icons.notifications),
            label: const Text(
              'Прислать пуш',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorSchemes.lightColorScheme.secondary,
              foregroundColor: AppColorSchemes.lightColorScheme.onSecondary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

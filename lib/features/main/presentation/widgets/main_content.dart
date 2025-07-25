import 'package:flutter/material.dart';
import '../../../../core/ui_kit/app_box.dart';
import '../../../auth/domain/entities/user.dart';
import 'action_buttons.dart';
import 'user_profile_card.dart';

class MainContent extends StatelessWidget {
  final User user;
  final VoidCallback? onPurchasePressed;
  final VoidCallback? onNotificationPressed;

  const MainContent({
    super.key,
    required this.user,
    required this.onPurchasePressed,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserProfileCard(user: user),
          const HBox(24),
          ActionButtons(
            onPurchasePressed: onPurchasePressed,
            onNotificationPressed: onNotificationPressed,
          ),
        ],
      ),
    );
  }
}

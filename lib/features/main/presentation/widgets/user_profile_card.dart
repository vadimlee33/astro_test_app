import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/color_schemes.dart';
import '../../../../core/ui_kit/app_box.dart';
import '../../../auth/domain/entities/user.dart';

class UserProfileCard extends StatelessWidget {
  final User user;

  const UserProfileCard({
    super.key,
    required this.user,
  });

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColorSchemes.lightColorScheme.primary,
          size: 20,
        ),
        const WBox(8),
        Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const WBox(8),
        Text(
          value,
          style: AppTextStyles.bodyLarge,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColorSchemes.lightColorScheme.primary,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: AppColorSchemes.lightColorScheme.onPrimary,
                  ),
                ),
                const WBox(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Профиль пользователя',
                        style: AppTextStyles.titleLarge,
                      ),
                      const HBox(4),
                      Text(
                        'ID: ${user.uid}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color:
                              AppColorSchemes.lightColorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const HBox(16),
            const Divider(),
            const HBox(8),
            _buildInfoRow(Icons.phone, 'Телефон:', user.phone),
            const HBox(8),
            _buildInfoRow(Icons.calendar_today, 'Дата регистрации:',
                '${user.createdAt.day}.${user.createdAt.month}.${user.createdAt.year}'),
            const HBox(8),
            _buildInfoRow(Icons.wallet, 'Баланс:', '${user.balance}'),
          ],
        ),
      ),
    );
  }
}

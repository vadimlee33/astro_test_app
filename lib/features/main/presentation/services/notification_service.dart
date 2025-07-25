import 'package:flutter/material.dart';
import '../../../../core/app/usecases/notification/check_notification_permissions.dart';
import '../../../../core/app/usecases/notification/request_notification_permissions.dart';
import '../../../../core/app/usecases/notification/show_notification.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/routing/app_route.dart';

class NotificationService {
  static Future<void> handleNotificationRequest(BuildContext context) async {
    final checkPermissions = sl<CheckNotificationPermissions>();
    final requestPermissions = sl<RequestNotificationPermissions>();

    final permissionsResult = await checkPermissions(const NoParams());

    permissionsResult.fold(
      (failure) {
        _showErrorSnackBar(
          context,
          'Ошибка проверки разрешений: ${failure.message}',
        );
      },
      (hasPermissions) async {
        if (hasPermissions) {
          await _showTestNotification(context);
        } else {
          await _requestPermissions(context, requestPermissions);
        }
      },
    );
  }

  static Future<void> _requestPermissions(
    BuildContext context,
    RequestNotificationPermissions requestPermissions,
  ) async {
    final requestResult = await requestPermissions(const NoParams());

    requestResult.fold(
      (failure) {
        _showErrorSnackBar(
          context,
          'Ошибка запроса разрешений: ${failure.message}',
        );
      },
      (granted) {
        if (granted) {
          _showTestNotification(context);
          _showSuccessSnackBar(
            context,
            'Разрешения на уведомления предоставлены!',
          );
        } else {
          _showWarningSnackBar(
            context,
            'Разрешения на уведомления не предоставлены',
          );
        }
      },
    );
  }

  static Future<void> _showTestNotification(BuildContext context) async {
    final showNotification = sl<ShowNotification>();
    await showNotification(
      const ShowNotificationParams(
        id: 999,
        title: 'Тестовое уведомление',
        body: 'Нажмите, чтобы вернуться на главную страницу',
        routePath: MainRoute.routeName,
      ),
    );
  }

  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void _showWarningSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

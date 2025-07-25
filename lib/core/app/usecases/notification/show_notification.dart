import 'package:dartz/dartz.dart';
import '../../../errors/failures.dart';
import '../../../services/notifications/notification_service.dart';
import '../../../usecase/usecase.dart';

class ShowNotification implements UseCase<void, ShowNotificationParams> {
  final NotificationService _notificationService;

  ShowNotification(this._notificationService);

  @override
  Future<Either<Failure, void>> call(ShowNotificationParams params) async {
    return await _notificationService.showNotification(
      id: params.id,
      title: params.title,
      body: params.body,
      routePath: params.routePath,
    );
  }
}

class ShowNotificationParams {
  final int id;
  final String title;
  final String body;
  final String routePath;

  const ShowNotificationParams({
    required this.id,
    required this.title,
    required this.body,
    required this.routePath,
  });
}

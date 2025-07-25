import 'package:dartz/dartz.dart';
import '../../../errors/failures.dart';
import '../../../services/notifications/notification_service.dart';
import '../../../usecase/usecase.dart';

class CheckNotificationPermissions implements UseCase<bool, NoParams> {
  final NotificationService _notificationService;

  CheckNotificationPermissions(this._notificationService);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _notificationService.areNotificationsEnabled();
  }
}

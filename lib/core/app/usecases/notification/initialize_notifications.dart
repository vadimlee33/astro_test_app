import 'package:dartz/dartz.dart';
import '../../../errors/failures.dart';
import '../../../services/notifications/notification_service.dart';
import '../../../usecase/usecase.dart';

class InitializeNotifications implements UseCase<void, NoParams> {
  final NotificationService _notificationService;

  InitializeNotifications(this._notificationService);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _notificationService.initialize();
  }
}

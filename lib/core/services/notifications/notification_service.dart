import 'package:dartz/dartz.dart';
import '../../errors/failures.dart';

abstract class NotificationService {
  Future<Either<Failure, void>> initialize();

  Future<Either<Failure, void>> showNotification({
    required int id,
    required String title,
    required String body,
    required String routePath,
  });
  Future<Either<Failure, bool>> requestPermissions();

  Future<Either<Failure, bool>> areNotificationsEnabled();
}

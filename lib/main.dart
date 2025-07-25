import 'package:flutter/material.dart';
import 'core/di/injection_container.dart' as di;
import 'core/app/usecases/notification/initialize_notifications.dart';
import 'core/usecase/usecase.dart';
import 'core/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  final initializeNotifications = di.sl<InitializeNotifications>();
  final result = await initializeNotifications(const NoParams());

  result.fold(
    (failure) =>
        print('Failed to initialize notifications: ${failure.message}'),
    (_) => print('Notifications initialized successfully'),
  );

  runApp(const MyApp());
}

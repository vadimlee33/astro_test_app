import 'package:get_it/get_it.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import '../storage/hive_config.dart';
import '../app/data_repository/user/user_repository.dart';
import '../app/data_repository/user/user_repository_impl.dart';
import '../services/notifications/notification_service.dart';
import '../services/notifications/notification_service_impl.dart';
import '../app/usecases/notification/show_notification.dart';
import '../app/usecases/notification/initialize_notifications.dart';
import '../app/usecases/notification/request_notification_permissions.dart';
import '../app/usecases/notification/check_notification_permissions.dart';
import '../routing/router.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/send_sms_code.dart';
import '../../features/auth/domain/usecases/verify_code.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/splash/domain/usecases/initialize_app.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../features/main/presentation/bloc/main_bloc.dart';
import '../../features/purchase/data/repositories/purchase_repository_impl.dart';
import '../../features/purchase/domain/repositories/purchase_repository.dart';
import '../../features/purchase/domain/usecases/make_purchase.dart';
import '../../features/purchase/presentation/bloc/purchase_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(sl<AuthRepository>()));

  sl.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );

  sl.registerLazySingleton<NotificationService>(
    () => NotificationServiceImpl(
      sl<FlutterLocalNotificationsPlugin>(),
      onNotificationTapped: (routePath) {
        try {
          final context = AppRouter.navigatorKey.currentContext;
          if (context != null) {
            GoRouter.of(context).go(routePath);
          } else {
            print('Context is null, cannot navigate to: $routePath');
          }
        } catch (e) {
          print('Navigation error: $e');
        }
      },
    ),
  );

  sl.registerLazySingleton(() => ShowNotification(sl()));
  sl.registerLazySingleton(() => InitializeNotifications(sl()));
  sl.registerLazySingleton(() => RequestNotificationPermissions(sl()));
  sl.registerLazySingleton(() => CheckNotificationPermissions(sl()));

  sl.registerFactory(
    () => AuthBloc(
      sendSmsCode: sl(),
      verifyCode: sl(),
      getCurrentUser: sl(),
      logout: sl(),
      userService: sl<UserRepository>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SendSmsCode(sl()));
  sl.registerLazySingleton(() => VerifyCode(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  //! Features - Splash
  // Bloc
  sl.registerFactory(
    () => SplashBloc(
      initializeApp: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => InitializeApp(
        getCurrentUser: sl(),
        userService: sl<UserRepository>(),
      ));

  //! Features - Main
  // Bloc
  sl.registerFactory(
    () => MainBloc(
      userService: sl<UserRepository>(),
    ),
  );

  sl.registerFactory(
    () => PurchaseBloc(
      repository: sl(),
      executePurchase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
      () => ExecutePurchase(sl<UserRepository>().incrementBalance));

  // Repository
  sl.registerLazySingleton<PurchaseRepository>(
    () => PurchaseRepositoryImpl(),
  );

  await _initHive();
}

Future<void> _initHive() async {
  await HiveConfig.initialize();

  sl.registerLazySingleton(() => HiveConfig.getUserBox());
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_route.dart';

part 'routing_scheme.dart';

abstract final class AppRouter {
  static String get initialLocation => '/splash';
  static GlobalKey<NavigatorState> get navigatorKey => _rootKey;

  static GoRouter get toGoRouter => GoRouter(
        routes: _routes,
        debugLogDiagnostics: true,
        initialLocation: initialLocation,
        navigatorKey: _rootKey,
      );
}

import 'package:astro_test_app/features/auth/presentation/pages/code_verification_page.dart';
import 'package:astro_test_app/features/auth/presentation/pages/phone_input_page.dart';
import 'package:astro_test_app/features/main/presentation/pages/main_page.dart';
import 'package:astro_test_app/features/purchase/presentation/pages/purchase_page.dart';
import 'package:astro_test_app/features/purchase/presentation/bloc/purchase_bloc.dart';
import 'package:astro_test_app/features/splash/splash.dart';
import 'package:astro_test_app/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'routes/auth_route.dart';
part 'routes/balance_route.dart';
part 'routes/purchase_route.dart';
part 'routes/splash_route.dart';
part 'routes/main_route.dart';

Widget $unimplementedRoute(String name) {
  return Scaffold(
    body: Center(
      child: Text('Route $name not implemented'),
    ),
  );
}

class AppRoute extends GoRoute {
  AppRoute({
    required String super.name,
    Widget? child,
    Page<dynamic> Function(BuildContext, GoRouterState)? pageBuilder,
    String? path,
    super.parentNavigatorKey,
    super.redirect,
    super.onExit,
    super.routes,
  }) : super(
          path: path ?? name,
          pageBuilder: child == null
              ? (pageBuilder ??
                  (context, state) => NoTransitionPage<void>(
                        name: name,
                        key: state.pageKey,
                        child: $unimplementedRoute(name),
                      ))
              : (context, state) => NoTransitionPage<void>(
                    name: name,
                    key: state.pageKey,
                    child: child,
                  ),
        );
}

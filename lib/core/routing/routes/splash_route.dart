part of '../app_route.dart';

class SplashRoute extends AppRoute {
  SplashRoute({
    super.parentNavigatorKey,
    super.redirect,
    super.onExit,
  }) : super(
          name: routeName,
          path: routeName,
          child: const SplashPage(),
        );

  static const routeName = '/splash';

  static void go(BuildContext context) => context.goNamed(routeName);
}

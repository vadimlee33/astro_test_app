part of '../app_route.dart';

class MainRoute extends AppRoute {
  MainRoute({
    super.parentNavigatorKey,
    super.redirect,
    super.onExit,
  }) : super(
          name: routeName,
          path: routeName,
          child: const MainPage(),
        );

  static const routeName = '/main';

  static void go(BuildContext context) => context.goNamed(routeName);
}

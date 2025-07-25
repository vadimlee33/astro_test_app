part of '../app_route.dart';

class BalanceRoute extends AppRoute {
  BalanceRoute({
    super.parentNavigatorKey,
    super.redirect,
    super.onExit,
  }) : super(
          name: routeName,
          path: routeName,
          child: const Scaffold(
            body: Center(
              child: Text('Balance Page'),
            ),
          ),
        );

  static const routeName = '/balance';

  static void go(BuildContext context) => context.goNamed(routeName);
}

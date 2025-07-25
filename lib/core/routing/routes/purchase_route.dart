part of '../app_route.dart';

class PurchaseRoute extends AppRoute {
  PurchaseRoute({
    super.parentNavigatorKey,
    super.redirect,
    super.onExit,
  }) : super(
          name: routeName,
          path: routeName,
          child: BlocProvider(
            create: (context) => sl<PurchaseBloc>(),
            child: const PurchasePage(),
          ),
        );

  static const routeName = '/purchase';

  static void go(BuildContext context) => context.pushNamed(routeName);
}

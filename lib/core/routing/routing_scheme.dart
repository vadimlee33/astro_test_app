part of 'router.dart';

final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();

final _routes = [
  SplashRoute(),
  AuthRoute(),
  MainRoute(),
  BalanceRoute(),
  PurchaseRoute(),
];

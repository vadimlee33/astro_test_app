part of '../app_route.dart';

class AuthRoute extends AppRoute {
  AuthRoute({
    super.parentNavigatorKey,
    super.redirect,
    super.onExit,
  }) : super(
          name: routeName,
          path: routeName,
          routes: [
            PhoneInputRoute(),
            CodeVerificationRoute(),
          ],
        );

  static const routeName = '/auth';

  static void go(BuildContext context) => context.goNamed(routeName);
}

class PhoneInputRoute extends AppRoute {
  PhoneInputRoute({
    super.parentNavigatorKey,
    super.redirect,
    super.onExit,
  }) : super(
          name: routeName,
          path: routeName,
          child: const PhoneInputPage(),
        );

  static const routeName = '/phone-input';

  static void go(BuildContext context) => context.goNamed(routeName);
}

class CodeVerificationRoute extends AppRoute {
  CodeVerificationRoute({
    super.parentNavigatorKey,
    super.redirect,
    super.onExit,
  }) : super(
          name: routeName,
          path: '$routeName/:phone',
          pageBuilder: (context, state) {
            final phone = state.pathParameters['phone'] ?? '';
            return NoTransitionPage<void>(
              name: routeName,
              key: state.pageKey,
              child: CodeVerificationPage(phone: phone),
            );
          },
        );

  static const routeName = '/code-verification';

  static void go(BuildContext context, String phone) =>
      context.goNamed(routeName, pathParameters: {'phone': phone});

  static void push(BuildContext context, String phone) =>
      context.pushNamed(routeName, pathParameters: {'phone': phone});
}

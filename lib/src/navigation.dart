import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/main.dart';
import '/routes/welcome.dart';
import '/routes/register.dart';
import '/routes/signin.dart';
import '/routes/error.dart';
import '/routes/home.dart';
import '/routes/finance.dart';
import '/routes/loans.dart';
import '/routes/cards.dart';
import '/routes/me.dart';

CustomTransitionPage slideDownToUpTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required var key,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    transitionDuration: const Duration(milliseconds: 300),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(0, 0.75),
          end: const Offset(0, 0),
        ).chain(
          CurveTween(curve: Curves.easeIn),
        ),
      ),
      child: child,
    ),
  );
}

CustomTransitionPage slideRightToLeftTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required var key,
}) {
  return CustomTransitionPage<T>(
    transitionDuration: const Duration(milliseconds: 300),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(0.75, 0),
          end: const Offset(0, 0),
        ).chain(
          CurveTween(curve: Curves.easeIn),
        ),
      ),
      child: child,
    ),
  );
}

//FadeIn Page Transition
CustomTransitionPage fadeTransitionWithKey<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required var key,
}) {
  return CustomTransitionPage<T>(
    transitionDuration: const Duration(milliseconds: 300),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      child: child,
    ),
  );
}

// private navigators
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final shellNavigatorMeetKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellFinance');
final shellNavigatorMessagesKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellLoans');
final shellNavigatorMatchesKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellCards');
final shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellMe');

final goRouter = GoRouter(
  initialLocation: '/',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: shellNavigatorHomeKey,
          routes: [
            //Home
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => fadeTransitionWithKey(
                context: context,
                state: state,
                key: UniqueKey,
                child: const Home(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorMeetKey,
          routes: [
            //Meet
            GoRoute(
              path: '/finance',
              pageBuilder: (context, state) => fadeTransitionWithKey(
                context: context,
                state: state,
                key: UniqueKey,
                child: const Finance(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorMessagesKey,
          routes: [
            // Messages
            GoRoute(
              path: '/loans',
              pageBuilder: (context, state) => fadeTransitionWithKey(
                context: context,
                state: state,
                key: UniqueKey,
                child: const Loans(),
              ),
              /* routes: [
                GoRoute(
                  path: 'message-page/:chatIDNumber',
                  pageBuilder: (context, state) => slideRightToLeftTransition(
                    context: context,
                    state: state,
                    key: UniqueKey(),
                    child: MessagePage(
                      chatIDNumber: int.parse(
                          state.pathParameters['chatIDNumber'].toString()),
                    ),
                  ),
                ),
              ], */
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorProfileKey,
          routes: [
            // Profile
            GoRoute(
              path: '/cards',
              pageBuilder: (context, state) => fadeTransitionWithKey(
                context: context,
                state: state,
                key: UniqueKey,
                child: const Cards(),
              ),
              /* routes: [
                GoRoute(
                  path: 'request',
                  pageBuilder: (context, state) => slideRightToLeftTransition(
                    context: context,
                    state: state,
                    key: UniqueKey(),
                    child: const Request(),
                  ),
                  
                ),
              ], */
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavigatorProfileKey,
          routes: [
            // Profile
            GoRoute(
              path: '/me',
              pageBuilder: (context, state) => fadeTransitionWithKey(
                context: context,
                state: state,
                key: UniqueKey,
                child: const Me(),
              ),
              /* routes: [
                GoRoute(
                  path: 'profile',
                  pageBuilder: (context, state) => slideRightToLeftTransition(
                    context: context,
                    state: state,
                    key: UniqueKey(),
                    child: const Profile(),
                  ),
                  
                ),
              ], */
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/welcome',
      pageBuilder: (context, state) => slideRightToLeftTransition(
        context: context,
        state: state,
        key: UniqueKey(),
        child: const Welcome(),
      ),
      routes: [
        GoRoute(
          path: 'signin',
          pageBuilder: (context, state) => slideDownToUpTransition(
            context: context,
            state: state,
            key: UniqueKey(),
            child: const SignIn(),
          ),
        ),
        GoRoute(
          path: 'register',
          pageBuilder: (context, state) => slideDownToUpTransition(
            context: context,
            state: state,
            key: UniqueKey(),
            child: const Register(),
          ),
        ),
      ],
    ),
  ],

  errorPageBuilder: (context, state) => MaterialPage<void>(
    key: state.pageKey,
    child: Error(state.error),
  ),

  // redirect to the login page if the user is not logged in
  redirect: (context, state) {
    //Get user from provider
    final loggedIn =
        Provider.of<UserProvider>(context, listen: false).isLoggedIn;

    //Initialize anonymous user routes
    final signin = state.fullPath == '/welcome/signin';
    final register = state.fullPath == '/welcome/register';
    final welcome = state.fullPath == '/welcome';

    //Check if user is logged in
    if (loggedIn != false) {
      if (signin || register || welcome) {
        return '/';
      } else {
        return null;
      }
    } else {
      if (signin || register || welcome) {
        return null;
      } else {
        return '/welcome';
      }
    }
  },
);

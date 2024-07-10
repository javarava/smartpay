import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/main.dart';
import '/routes/welcome.dart';
import '/routes/signup.dart';
import '/routes/signin.dart';
import '/routes/error.dart';
import '/routes/home.dart';
import '/routes/finance.dart';
import '/routes/loans.dart';
import '/routes/cards.dart';
import '/routes/me.dart';
import '/routes/signinpinverify.dart';
import '/src/datastorage.dart';

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
final shellNavigatorFinanceKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellFinance');
final shellNavigatorLoansKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellLoans');
final shellNavigatorCardsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellCards');
final shellNavigatorMeKey = GlobalKey<NavigatorState>(debugLabel: 'shellMe');

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
          navigatorKey: shellNavigatorFinanceKey,
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
          navigatorKey: shellNavigatorLoansKey,
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
          navigatorKey: shellNavigatorCardsKey,
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
          navigatorKey: shellNavigatorMeKey,
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
          pageBuilder: (context, state) => slideRightToLeftTransition(
            context: context,
            state: state,
            key: UniqueKey(),
            child: const SignIn(),
          ),
        ),
        GoRoute(
          path: 'signup',
          pageBuilder: (context, state) => slideRightToLeftTransition(
            context: context,
            state: state,
            key: UniqueKey(),
            child: const SignUp(),
          ),
        ),
        GoRoute(
          path: 'signinpinverify',
          pageBuilder: (context, state) => slideRightToLeftTransition(
            context: context,
            state: state,
            key: UniqueKey(),
            child: const SignInPinVerify(),
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
  redirect: (context, state) async {
    try {
      final user =
          Provider.of<UserProvider>(context, listen: false).loggedinUser;

      //Initialize anonymous user routes
      final signin = state.fullPath == '/welcome/signin';
      final signinpinverify = state.fullPath == '/welcome/signinpinverify';
      final signup = state.fullPath == '/welcome/signup';
      final welcome = state.fullPath == '/welcome';

      //Read user details from details.txt file on user's device

      final directory = await getApplicationDocumentsDirectory();
      final localPath = directory.path;
      final file = File('$localPath/details.txt');

      bool? fileExists = await file.exists();

      if (fileExists == true) {
        //debugPrint('Details File Path: $localPath/details.txt');
        final jsonStr = await file.readAsString();
        Map? fileJson = jsonDecode(jsonStr) as Map<String, dynamic>;

        if (fileJson.containsKey('id') && user!.isEmpty) {
          //user registered, not logged in
          //GO TO LOGIN PIN VERIFY PAGE
          return '/welcome/signinpinverify';
        } else if (fileJson.containsKey('id') && user!.isNotEmpty) {
          //user registered, not logged in
          //GO TO HOME
          return '/';
        } else {
          //user not registered
          return '/welcome/signin';
        }
      } else {
        //user not registered

        if (signin || signup || welcome || signinpinverify) {
          return null;
        } else {
          return '/welcome';
        }
      }

      /* final detailsFile = await readDetailsFile();

      //final loggedIn = Provider.of<UserProvider>(context, listen: true).loggedinUser;

      debugPrint('LoggedInNav = $loggedIn');

      //Initialize anonymous user routes
      final signin = state.fullPath == '/welcome/signin';
      final signup = state.fullPath == '/welcome/signup';
      final welcome = state.fullPath == '/welcome';

      //Check if user is logged in or not and redirect accordingly
      if (loggedIn != null) {
        if (signin || signup || welcome) {
          return '/';
        } else {
          return null;
        }
      } else {
        if (signin || signup || welcome) {
          return null;
        } else {
          return '/welcome';
        }
      } */
    } catch (e) {
      debugPrint('An error occurred! $e');

      return null;
    }
  },
);

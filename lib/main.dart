import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '/providers/user_provider.dart';
import '/src/theme.dart';
import '/src/navigation.dart';

//initialize user variables
Map? loggedinUser;
String? userID;
String? userEmail;

void main() async {
  // turn off the # in the URLs on the web
  usePathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  //Disable App rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    usePathUrlStrategy();
    runApp(
      Phoenix(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => UserProvider(),
            ),
          ],
          child: const MyApp(),
        ),
      ),
    );
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  //Get the credentials of the user
  Future<void> getCurrentUser() async {
    try {
      /* final user = auth.currentUser;
      if (user != null) {
        loggedinUser = user;
        userID = user.uid;
        userEmail = user.email;
      } */
    } catch (e) {
      debugPrint('An error occurred: $e');
    }
  }

  @override
  void initState() {
    setState(
      () {
        loggedinUser = null;
      },
    );

    getCurrentUser();

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    //Get user data from provider
    loggedinUser = context.watch<UserProvider>().loggedinUser;

    loggedinUser != null ? userID = loggedinUser!['id'] : userID = null;

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'SmartPay',
      theme: AppTheme.lightTheme(),
      //darkTheme: AppTheme.lightTheme(),
      //Remove Scroll Glow
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: RemoveScrollGlow(),
          child: child!,
        );
      },
    );
  }
}

// Stateful navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          navigationShell,
          navigationShell.currentIndex,
          goBranch,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: goBranch,
        );
      }
    });
  }
}

class ScaffoldWithNavigationBar extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const ScaffoldWithNavigationBar(
      this.body, this.selectedIndex, this.onDestinationSelected,
      {super.key});

  @override
  State<ScaffoldWithNavigationBar> createState() =>
      _ScaffoldWithNavigationBarState();
}

class _ScaffoldWithNavigationBarState extends State<ScaffoldWithNavigationBar> {
  @override
  Widget build(BuildContext context) {
    Widget body = widget.body;
    int selectedIndex = widget.selectedIndex;
    Function(int) onDestinationSelecteds = widget.onDestinationSelected;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: body,
      bottomNavigationBar: CustomNavigationBar(
        iconSize: 25.0,
        selectedColor: smartpayBlack.shade900,
        strokeColor: smartpayBlack.shade800,
        unSelectedColor: smartpayBlack.shade500,
        backgroundColor: smartpayBlack.shade50,
        bubbleCurve: Curves.elasticIn,
        currentIndex: selectedIndex,
        onTap: onDestinationSelecteds,
        items: [
          CustomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('home-variant')),
            selectedIcon: Icon(MdiIcons.fromString('home-variant')),
            title: Text(
              "Home",
              style: AppTheme.buttonNavigationText(),
            ),
            selectedTitle: Text(
              "Home",
              style: AppTheme.buttonNavigationSelectedText(),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('finance')),
            selectedIcon: Icon(MdiIcons.fromString('finance')),
            title: Text(
              "Finance",
              style: AppTheme.buttonNavigationText(),
            ),
            selectedTitle: Text(
              "Finance",
              style: AppTheme.buttonNavigationSelectedText(),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('cash-multiple')),
            selectedIcon: Icon(MdiIcons.fromString('cash-multiple')),
            title: Text(
              "Loans",
              style: AppTheme.buttonNavigationText(),
            ),
            selectedTitle: Text(
              "Loans",
              style: AppTheme.buttonNavigationSelectedText(),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('credit-card-outline')),
            selectedIcon: Icon(MdiIcons.fromString('credit-card-outline')),
            title: Text(
              "Cards",
              style: AppTheme.buttonNavigationText(),
            ),
            selectedTitle: Text(
              "Cards",
              style: AppTheme.buttonNavigationSelectedText(),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(MdiIcons.fromString('account-outline')),
            selectedIcon: Icon(MdiIcons.fromString('account-outline')),
            title: Text(
              "Me",
              style: AppTheme.buttonNavigationText(),
            ),
            selectedTitle: Text(
              "Me",
              style: AppTheme.buttonNavigationSelectedText(),
            ),
          ),
        ],
      ),
    );
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                label: const Text('Home'),
                icon: Icon(MdiIcons.fromString('home-variant')),
              ),
              NavigationRailDestination(
                label: const Text('Finance'),
                icon: Icon(MdiIcons.fromString('finance')),
              ),
              NavigationRailDestination(
                label: const Text('Loans'),
                icon: Icon(MdiIcons.fromString('cash-multiple')),
              ),
              NavigationRailDestination(
                label: const Text('Cards'),
                icon: Icon(MdiIcons.fromString('credit-card-outline')),
              ),
              NavigationRailDestination(
                label: const Text('Me'),
                icon: Icon(MdiIcons.fromString('account')),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}

//Remove Scroll Glow
class RemoveScrollGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

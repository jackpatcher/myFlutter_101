// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _sectionANavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'sectionANav');
final GlobalKey<NavigatorState> _sectionBNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'sectionBNav');

// This example demonstrates how to setup nested navigation using a
// BottomNavigationBar, where each tab uses its own persistent navigator, i.e.
// navigation state is maintained separately for each tab. This setup also
// enables deep linking into nested pages.
//
// This example demonstrates how to display routes within a ShellRoute using a
// `nestedNavigationBuilder`. Navigators for the tabs ('Section A' and
// 'Section B') are created via nested ShellRoutes. Note that no navigator will
// be created by the "top" ShellRoute. This example is similar to the ShellRoute
// example, but differs in that it is able to maintain the navigation state of
// each tab.

void main() {
  runApp(NestedTabNavigationExampleApp());
}

/// An example demonstrating how to use nested navigators
class NestedTabNavigationExampleApp extends StatelessWidget {
  /// Creates a NestedTabNavigationExampleApp
  NestedTabNavigationExampleApp({Key? key}) : super(key: key);

  static final List<ScaffoldWithNavBarTabItem> _tabs =
  <ScaffoldWithNavBarTabItem>[
    ScaffoldWithNavBarTabItem(rootRoutePath: '/a',
        navigatorKey: _sectionANavigatorKey,
        icon: const Icon(Icons.home), label: 'Section A'),
    ScaffoldWithNavBarTabItem(rootRoutePath: '/b',
      navigatorKey: _sectionBNavigatorKey,
      icon: const Icon(Icons.settings), label: 'Section B', ),
  ];

  final GoRouter _router = GoRouter(
    initialLocation: '/a',
    routes: <RouteBase>[
      /// Custom top shell route - wraps the below routes in a scaffold with
      /// a bottom tab navigator (ScaffoldWithNavBar). Note that no Navigator
      /// will be created by this top ShellRoute.
      BottomTabBarShellRoute(
        tabs: _tabs,
        routes: <RouteBase>[
          /// The screen to display as the root in the first tab of the bottom
          /// navigation bar.
          GoRoute(
            path: '/a',
            builder: (BuildContext context, GoRouterState state) =>
            const RootScreen(label: 'A', detailsPath: '/a/details'),
            routes: <RouteBase>[
              /// The details screen to display stacked on navigator of the
              /// first tab. This will cover screen A but not the application
              /// shell (bottom navigation bar).
              GoRoute(
                path: 'details',
                builder: (BuildContext context, GoRouterState state) =>
                  const DetailsScreen(label: 'A'),
              ),
            ],
          ),
          /// The screen to display as the root in the second tab of the bottom
          /// navigation bar.
          GoRoute(
            path: '/b',
            builder: (BuildContext context, GoRouterState state) =>
            const RootScreen(label: 'B', detailsPath: '/b/details/1', detailsPath2: '/b/details/2'),
            routes: <RouteBase>[
              /// The details screen to display stacked on navigator of the
              /// second tab. This will cover screen B but not the application
              /// shell (bottom navigation bar).
              GoRoute(
                path: 'details/:param',
                builder: (BuildContext context, GoRouterState state) =>
                DetailsScreen(label: 'B', param: state.params['param']),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

/// ShellRoute that uses a bottom tab navigation (ScaffoldWithNavBar) with
/// separate navigators for each tab.
///
/// NOTE: This is not an optimal implementation and should ideally be
/// implemented in go_router, although in a way that doesn't use a navigator.
/// Here is a proposed implementation:
/// https://github.com/tolo/flutter_packages/tree/nested-persistent-navigation/packages/go_router
class BottomTabBarShellRoute extends ShellRoute {
  final List<ScaffoldWithNavBarTabItem> tabs;
  BottomTabBarShellRoute({
    required this.tabs,
    GlobalKey<NavigatorState>? navigatorKey,
    List<RouteBase> routes = const <RouteBase>[],
    Key? scaffoldKey = const ValueKey('ScaffoldWithNavBar'),
  }) : super(
      navigatorKey: navigatorKey,
      routes: routes,
      builder: (context, state, Widget fauxNav) {
        return Stack(children: [
          // Needed to keep the (faux) shell navigator alive
          Offstage(child: fauxNav),
          ScaffoldWithNavBar(tabs: tabs, key: scaffoldKey,
            currentNavigator: fauxNav as Navigator,
            currentRouterState: state, routes: routes),
        ]);
      }
  );
}

/// Representation of a tab item in a [ScaffoldWithNavBar]
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  /// Constructs an [ScaffoldWithNavBarTabItem].
  const ScaffoldWithNavBarTabItem({required this.rootRoutePath,
    required this.navigatorKey, required Widget icon, String? label}) :
        super(icon: icon, label: label);

  /// The initial location/path
  final String rootRoutePath;

  /// Optional navigatorKey
  final GlobalKey<NavigatorState> navigatorKey;
}


/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatefulWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.currentNavigator,
    required this.currentRouterState,
    required this.tabs,
    required this.routes,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigator for the currently active tab
  final Navigator currentNavigator;

  /// The pages for the current route
  List<Page<dynamic>> get pagesForCurrentRoute => currentNavigator.pages;

  /// The current router state
  final GoRouterState currentRouterState;

  /// The tabs
  final List<ScaffoldWithNavBarTabItem> tabs;

  // The routes
  final List<RouteBase> routes;

  @override
  State<StatefulWidget> createState() => ScaffoldWithNavBarState();
}

/// State for ScaffoldWithNavBar
class ScaffoldWithNavBarState extends State<ScaffoldWithNavBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final List<_NavBarTabNavigator> _tabs;

  //
  int _locationToTabIndex(String location) {
    final int index = _tabs.indexWhere(
            (_NavBarTabNavigator t) => location.startsWith(t.rootRoutePath));
    return index < 0 ? 0 : index;
  }

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabs = widget.tabs
        .map((ScaffoldWithNavBarTabItem e) => _NavBarTabNavigator(e))
        .toList();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant ScaffoldWithNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateForCurrentTab();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateForCurrentTab();
  }

  void _updateForCurrentTab() {
    final int previousIndex = _currentIndex;
    final location = GoRouter.of(context).location;
    _currentIndex = _locationToTabIndex(location);

    final _NavBarTabNavigator tabNav = _tabs[_currentIndex];
    tabNav.pages = widget.pagesForCurrentRoute;
    tabNav.lastLocation = location;

    if (previousIndex != _currentIndex) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        items: _tabs
            .map((_NavBarTabNavigator e) => e.bottomNavigationTab)
            .toList(),
        currentIndex: _currentIndex,
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FadeTransition(
        opacity: _animationController,
        child: IndexedStack(
            index: _currentIndex,
            children: _tabs
                .map((_NavBarTabNavigator tab) => tab.buildNavigator(context))
                .toList()));
  }

  void _onItemTapped(int index, BuildContext context) {
    GoRouter.of(context).go(_tabs[index].currentLocation);
  }
}

/// Class representing a tab along with its navigation logic
class _NavBarTabNavigator {
  _NavBarTabNavigator(this.bottomNavigationTab);

  final ScaffoldWithNavBarTabItem bottomNavigationTab;

  String? lastLocation;

  String get currentLocation =>
      lastLocation != null ? lastLocation! : rootRoutePath;

  String get rootRoutePath => bottomNavigationTab.rootRoutePath;
  Key? get navigatorKey => bottomNavigationTab.navigatorKey;
  List<Page<dynamic>> pages = <Page<dynamic>>[];

  Widget buildNavigator(BuildContext context) {
    if (pages.isNotEmpty) {
      return Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (Route<dynamic> route, dynamic result) {
          if (pages.length == 1 || !route.didPop(result)) {
            return false;
          }
          GoRouter.of(context).pop();
          return true;
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class RootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const RootScreen({required this.label, required this.detailsPath,
    this.detailsPath2, Key? key})
      : super(key: key);

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  /// The path to another detail page
  final String? detailsPath2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab root - $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(detailsPath);
              },
              child: const Text('View details'),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            if (detailsPath2 != null) TextButton(
              onPressed: () {
                GoRouter.of(context).go(detailsPath2!);
              },
              child: const Text('View more details'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    this.param,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  final String? param;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen - ${widget.label}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.param != null)
              Text('Parameter: ${widget.param!}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            Text('Details for ${widget.label} - Counter: $_counter',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
          ],
        ),
      ),
    );
  }
}
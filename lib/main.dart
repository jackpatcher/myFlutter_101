import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_routemaster/pages/inc_a01.dart';
import 'package:routemaster/routemaster.dart';

import 'routes/inc_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConst.appName,
      theme: AppTheme.initTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) => RouteMap(
          routes: mainRoute,
        ),
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

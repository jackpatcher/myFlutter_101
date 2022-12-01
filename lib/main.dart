import 'package:flutter/material.dart';
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
      title: "myApp",
      debugShowCheckedModeBanner: false,
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) => RouteMap(
          routes: mainRoute,
        ),
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}


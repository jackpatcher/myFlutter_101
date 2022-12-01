
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import '../pages/a01_app/inc_a01.dart';
 import 'inc_route.dart';

var mainRoute = {
            '/': (_) => const IndexedPage(
                  child: HomeScreen(),
                  paths: ['/a01/p1', '/a01/p2','/a01/p3','/a01/p4','/feed',],
                ),
            '/a01/p1': (_) =>   MaterialPage(child: Page1(title:"P1")),
            '/a01/p2': (_) =>   MaterialPage(child: Page2(title:"P2")),
            '/a01/p3': (_) =>    MaterialPage(child: Page3(title:"P3")),
            '/a01/p4': (_) =>   MaterialPage(child: Page4(title:"P4")),
            '/feed': (_) => const MaterialPage(child: FeedPage()),
            '/feed/profile/:id': (info) => MaterialPage(
                  child: ProfilePage(title: info.pathParameters['id']!),
                ),
          };

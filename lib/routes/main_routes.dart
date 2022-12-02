import 'package:flutter/material.dart';
import 'package:my_routemaster/routes/menu_nav_route.dart';
import 'package:routemaster/routemaster.dart';
import '../pages/inc_a01.dart';
import 'inc_route.dart';

var mainRoute = {
  '/': (_) =>   IndexedPage(
        child: const MainLayout(),
        paths: [
          '/${AppConst.appID}/${navItems[0].route}',
          '/${AppConst.appID}/${navItems[1].route}',
          '/${AppConst.appID}/${navItems[2].route}',
          '/${AppConst.appID}/${navItems[3].route}',
          '/${AppConst.appID}/${navItems[4].route}',
        ],
      ),
  '/${AppConst.appID}/${navItems[0].route}': (_) =>   MaterialPage(child: Page1(title: navItems[0].label)),
  '/${AppConst.appID}/${navItems[1].route}': (_) =>   MaterialPage(child: Page2(title: navItems[1].label)),
  '/${AppConst.appID}/${navItems[2].route}': (_) =>   MaterialPage(child: Page3(title: navItems[2].label)),
  '/${AppConst.appID}/${navItems[3].route}': (_) =>   MaterialPage(child: Page4(title: navItems[3].label)),
  '/${AppConst.appID}/${navItems[4].route}': (_) => const MaterialPage(child: FeedPage()),
  '/feed/profile/:id': (info) => MaterialPage(
        child: ProfilePage(title: info.pathParameters['id']!),
      ),
};

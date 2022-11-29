import 'package:flutter/material.dart';
class NavigationList {
  final Icon icon;
  final Icon activeIcon;
  final String label;
  final String route;
  final Color color;
  final int tabIndex;

  NavigationList(
 
      {
      required this.tabIndex,
      required this.route,
      required this.icon,
      required this.activeIcon,
      required this.label, 
      required this.color,

      });
}

// ignore: non_constant_identifier_names
List<NavigationList> tabs = [
  NavigationList(
      tabIndex:0,
      icon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home),
      label: "หน้าแรก",
      route: "/home",
      color:Colors.pink),
  NavigationList(
      tabIndex:1,
      icon: const Icon(Icons.favorite_border),
      activeIcon: const Icon(Icons.favorite),
      label: "บันทึก",
      route: "/tab1",
      color:Colors.blue), 
  NavigationList(
      tabIndex:2,
      icon: const Icon(Icons.bookmark_border),
      activeIcon: const Icon(Icons.book),
      label: "ข้อมูล",
      route: "/tab2",
      color:Colors.green), 
  NavigationList(
      tabIndex:3,
      icon: const Icon(Icons.star_border),
      activeIcon: const Icon(Icons.star),
      label: "รายงาน",
      route: "/tab3",
      color:Colors.grey), 
];

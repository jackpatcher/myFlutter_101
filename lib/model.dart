import 'package:flutter/material.dart';
class NavigationList {
  final Icon icon;
  final Icon activeIcon;
  final String label;
  final String route;
  final Color color;

  NavigationList(
      {required this.route,
      required this.icon,
      required this.activeIcon,
      required this.label, 
      required this.color,
      });
}

// ignore: non_constant_identifier_names
List<NavigationList> tabs = [
  NavigationList(
      icon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home),
      label: "หน้าแรก",
      route: "/",
      color:Colors.pink),
  NavigationList(
      icon: const Icon(Icons.favorite_border),
      activeIcon: const Icon(Icons.favorite),
      label: "บันทึก",
      route: "/a",
      color:Colors.blue), 
  NavigationList(
      icon: const Icon(Icons.bookmark_border),
      activeIcon: const Icon(Icons.book),
      label: "ข้อมูล",
      route: "/b",
      color:Colors.green), 
  NavigationList(
      icon: const Icon(Icons.star_border),
      activeIcon: const Icon(Icons.star),
      label: "รายงาน",
      route: "/page4",
      color:Colors.grey), 
];

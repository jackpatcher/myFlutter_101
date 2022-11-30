import 'package:flutter/material.dart';


List<Navigationlist> navItems = [
  Navigationlist(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: "หน้าแรก",
      route: "/page1",
      color:Colors.pink),
  Navigationlist(
      icon: Icons.favorite_border,
      activeIcon: Icons.favorite,
      label: "บันทึก",
      route: "/page2",
      color:Colors.blue), 
  Navigationlist(
      icon: Icons.bookmark_border,
      activeIcon: Icons.book,
      label: "ข้อมูล",
      route: "/page3",
      color:Colors.green), 
  Navigationlist(
      icon: Icons.star_border,
      activeIcon: Icons.star,
      label: "รายงาน",
      route: "/page4",
   color:Colors.grey), 
        Navigationlist(
      icon: Icons.star_border,
      activeIcon: Icons.star,
      label: "feed",
      route: "/feed",
      color:Colors.grey), 
];


class Navigationlist {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final Color color;

  Navigationlist(
      {required this.route,
      required this.icon,
      required this.activeIcon,
      required this.label, 
      required this.color,
      });
}
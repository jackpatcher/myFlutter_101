import 'package:flutter/material.dart';


List<Navigationlist> navItems = [
  Navigationlist(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: "หน้าแรก",
      route: "p1",
      color:Colors.pink),
  Navigationlist(
      icon: Icons.ondemand_video_outlined,
      activeIcon: Icons.ondemand_video,
      label: "คลิปสอน",
      route: "p2",
      color:Colors.blue), 
  Navigationlist(
      icon: Icons.bookmark_border,
      activeIcon: Icons.book,
      label: "ข้อมูล",
      route: "p3",
      color:Colors.green), 
  Navigationlist(
      icon: Icons.star_border,
      activeIcon: Icons.star,
      label: "รายงาน",
      route: "p4",
   color:Colors.grey), 
        Navigationlist(
      icon: Icons.star_border,
      activeIcon: Icons.star,
      label: "feed",
      route: "feed",
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
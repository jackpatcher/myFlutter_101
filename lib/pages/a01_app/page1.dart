import 'package:flutter/material.dart';
class Page1 extends StatelessWidget {
  final String title;

  const Page1({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)),
      body:Center(child:  Text(title)),);
  }
}
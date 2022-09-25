import 'package:flutter/material.dart';
import 'package:gsheet2/services/gsheet.dart';
import 'package:gsheet2/ui/addPage.dart';
import 'package:gsheet2/ui/homePage.dart';
import 'package:gsheet2/ui/dt1.dart';



const String routeAdd = '/add';
const String routeHome = '/';
const String routeDt1 = '/Dt1';

class SheetsApp extends StatelessWidget {
  final GoogleSheetsProvider sheet;

  const SheetsApp({
    required this.sheet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Std test Demo Am',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: routeDt1,
      routes: {
        routeHome: (_) => HomePage(provider: sheet),
        routeAdd: (_) => AddPage(provider: sheet),
        routeDt1: (_) => Dt1(provider: sheet),
      },
    );
  }
}
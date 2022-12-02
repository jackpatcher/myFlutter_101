import 'package:flutter/material.dart';

const kFontColorPallets = [
  Color.fromARGB(255, 209, 52, 0),
  Color.fromARGB(255, 81, 205, 64),
  Color.fromARGB(255, 8, 135, 233),
];
const kBorderRadius = 10.0;
const kSpacing = 15.0;

Color  getSequenceColor(  index) {
  List<Color> colors = const [
    Color.fromARGB(255,0, 192, 250),
    Color.fromARGB(255, 231, 78, 76),
    Color.fromARGB(255, 15, 209, 115),
    Color.fromARGB(255, 237, 156, 6),
    Color.fromARGB(255, 111, 35, 243),
  ];

  int val = index % 5;

  return colors[val];
}

class AppConst{
  static String appName = "KruTarn Academy";
  static String appID = "a01";

}

class AppTheme {
  static ThemeData get initTheme => myTree;

  static ThemeData get basic => ThemeData(
      
        canvasColor: Colors.white,
        primarySwatch: Colors.indigo,
        primaryColor: Colors.green.shade800,
        backgroundColor: Colors.green.shade800,
        scaffoldBackgroundColor: Colors.white,
      );
  static ThemeData get myTree => ThemeData(
       
        canvasColor: Colors.white,
        primarySwatch: Colors.blue,
        primaryColor: Colors.green.shade800,
        backgroundColor: Colors.green.shade800,
        scaffoldBackgroundColor: Colors.white,
        
        textTheme: const TextTheme(
          headline2: TextStyle(
            fontSize: 18.0,
            //fontWeight: FontWeight.w800,
            color: Colors.black54,
          ),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          
        ),
      );

  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    bottomAppBarColor: Colors.cyan,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.cyan,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    bottomAppBarColor: Colors.deepPurple,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepPurple,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // you can add other custom theme in this class like  light theme, dark theme ,etc.

  // example :
  // static ThemeData get light => ThemeData();
  // static ThemeData get dark => ThemeData();
}
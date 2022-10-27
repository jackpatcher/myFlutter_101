import 'package:dinsor_os/sys/config/cons/sys_lib_cons.dart';
import 'package:flutter/material.dart';

/// all custom application theme
class AppTheme {
  static ThemeData get initTheme => myTree;

  static ThemeData get basic => ThemeData(
        fontFamily: Font.nunito,
        canvasColor: Colors.white,
        primarySwatch: Colors.indigo,
        primaryColor: Colors.green.shade800,
        backgroundColor: Colors.green.shade800,
        scaffoldBackgroundColor: Colors.white,
      );
  static ThemeData get myTree => ThemeData(
        fontFamily: Font.nunito,
        canvasColor: Colors.white,
        primarySwatch: Colors.indigo,
        primaryColor: Colors.green.shade800,
        backgroundColor: Colors.green.shade800,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline2: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            color: Color.fromARGB(221, 107, 51, 2),
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

class HeaderText extends StatelessWidget {
  const HeaderText(this.data, {Key? key}) : super(key: key);

  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: AppTheme.initTheme.textTheme.headline2,
    );
  }
}

get sys_getHeaderColor {
  return AppTheme.initTheme.textTheme.headline2?.color;
}

Color sys_getSequenceColor(int index) {
  List<Color> colors = [    Colors.lightBlue,
    Colors.redAccent,
    Color.fromARGB(255, 242, 158, 47),
    Color.fromARGB(255, 111, 35, 243),
    Color.fromARGB(255, 15, 209, 115),
  ];

  int val = index % 5;
   
  return colors[val];
}

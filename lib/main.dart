import 'package:flutter/material.dart';
import 'package:flutter_api1/view/stdCrudApp_listView.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const StdCrudApp(),
       debugShowCheckedModeBanner: false,
     
    );
  }
}
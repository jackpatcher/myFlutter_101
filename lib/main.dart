import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'sys/config/routes/app_pages.dart';
import 'sys/config/themes/app_theme.dart';

 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dinsor School OS',
      theme: AppTheme.initTheme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      scrollBehavior: CustomScrollBehaviour(),
      
      debugShowCheckedModeBanner: false,
      
    );
  }
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

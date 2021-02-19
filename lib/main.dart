import 'package:flutter/material.dart';
import 'package:love_calculator/pages/splash_page.dart';
import 'package:love_calculator/utils/style/themes/base_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance',
      debugShowCheckedModeBanner: false,
      theme: baseTheme,
      home: SplashPage(),
    );
  }
}

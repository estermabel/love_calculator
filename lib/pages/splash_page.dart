import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love_calculator/utils/style/animations/fade_animation.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadData() async {
    await Future.delayed(new Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeAnimation(0.7, _icon()),
          FadeAnimation(1.4, _textTitle()),
        ],
      ),
    );
  }

  Padding _textTitle() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        "Love Calculator",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }

  IconTheme _icon() {
    return IconTheme(
      data: Theme.of(context).iconTheme,
      child: Icon(Icons.favorite),
    );
  }
}

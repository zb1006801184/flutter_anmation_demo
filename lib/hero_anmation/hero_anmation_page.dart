import 'package:flutter/material.dart';

class HeroAnmationPage extends StatefulWidget {
  @override
  _HeroAnmationPageState createState() => _HeroAnmationPageState();
}

class _HeroAnmationPageState extends State<HeroAnmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero动画'),
      ),
      body: Hero(
          tag: 'hero',
          child: Center(
            child: Text(
              'hero动画',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none),
            ),
          )),
    );
  }
}

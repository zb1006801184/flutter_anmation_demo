import 'package:flutter/material.dart';
import 'package:flutter_anmation_demo/combined_Animation/combined_animation_page.dart';
import 'package:flutter_anmation_demo/custom_painter/custom_painter_page.dart';
import 'package:flutter_anmation_demo/explicit_anmation/explicit_anmation_page.dart';
import 'package:flutter_anmation_demo/hero_anmation/hero_anmation_page.dart';
import 'package:flutter_anmation_demo/implicit_anmation/implicit_anmation.dart';
import 'package:flutter_anmation_demo/physics_anmation/physics_anmation_page.dart';
import 'package:flutter_anmation_demo/physics_anmation/physics_anmation_page2.dart';
import './animate_widget_demo/animate_widget_demo.dart';
import './tween_animated_builder/tween_animated_builder_demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

const textStyle = TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500, decoration: TextDecoration.none);

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<String> _titles = [
    '隐式动画',
    '显式动画',
    'hero动画',
    '基于物理的动画（弹簧模拟）',
    '基于物理的动画（自由落体）',
    '交织动画',
    'CustomPainter',
    'AnimateWidget',
    'TweenAnimatedBuilder',
  ];
  List _pages = [
    ImplicitAnmationPage(),
    ExplicitAnmationPage(),
    HeroAnmationPage(),
    PhysicsAnmationPage2(),
    PhysicsAnmationPage(),
    CombinedAnimationPage(),
    CustomPainrerPage(),
    AnimateWidgetDemo(),
    TweenAnimatedBuilderDemo(),
  ];

  void _itemClick({int index}) {
    print(_titles[index]);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => _pages[index]));
  }

  Widget _itemWidget({int index}) {
    if (index == 2) {
      return GestureDetector(
        child: Hero(
          tag: 'hero',
          child: Center(
            child: Text(_titles[index], style: textStyle),
          ),
        ),
        onTap: () {
          _itemClick(index: index);
        },
      );
    }

    return GestureDetector(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Center(
          child: Text(_titles[index], style: textStyle),
        ),
      ),
      onTap: () {
        _itemClick(index: index);
      },
    );
  }

  Widget _bodyWidget() {
    return ListView.builder(
        itemExtent: 44,
        itemCount: _titles.length,
        itemBuilder: (context, index) {
          return _itemWidget(index: index);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Anmation Demo'),
      ),
      body: _bodyWidget(),
    );
  }
}

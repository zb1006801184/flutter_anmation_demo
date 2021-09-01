import 'dart:async';
import 'dart:isolate';

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

  ///单向调用
/////在父Isolate中调用
//   Isolate isolate;
//   start() async {
//     ReceivePort receivePort = ReceivePort();
//     //创建子Isolate对象
//     isolate = await Isolate.spawn(getMsg, receivePort.sendPort);
//     //监听子Isolate的返回数据
//     receivePort.listen((data) {
//       print('data：$data');
//       receivePort.close();
//       //关闭Isolate对象
//       isolate?.kill(priority: Isolate.immediate);
//       isolate = null;
//     });
//   }

// //子Isolate对象的入口函数，可以在该函数中做耗时操作
//   static getMsg(sendPort) => sendPort.send("hello");

//双向通信
  Future<SendPort> initIsolate() async {
    Completer completer = new Completer<SendPort>();
    //主isolate中的接收者（接收子isolate中发送的消息）
    ReceivePort isolateToMainStream = ReceivePort();
    //接受者的监听
    isolateToMainStream.listen((data) {
      if (data is SendPort) {
        //接收到子isolate中创建的 SendPort，可使用该SendPort向子isolate发送消息
        SendPort mainToIsolateStream = data;
        completer.complete(mainToIsolateStream);
      } else {
        print('[isolateToMainStream] $data');
      }
    });
    //创建子isolate，传入 入口函数 和 接受者sendPort  ，子isolate可使用该sendPort向主isolate发送消息
    Isolate myIsolateInstance = await Isolate.spawn(myIsolate, isolateToMainStream.sendPort);
    return completer.future;
    //1
  }

//子Isolate的入口函数，可以在该函数中做耗时操作
//_isolate必须是顶级函数（不能存在任何类中）或者是静态函数（可以存在类中）
  static void myIsolate(SendPort isolateToMainStream) {
    ReceivePort mainToIsolateStream = ReceivePort();
    isolateToMainStream.send(mainToIsolateStream.sendPort);

    mainToIsolateStream.listen((data) {
      print('[mainToIsolateStream] $data');
    });

    isolateToMainStream.send('This is from myIsolate()');
  }

  void start() async {
    SendPort mainToIsolateStream = await initIsolate();
    //接收到子ioslate中的 SendPort   可向子isolate中发送消息
    mainToIsolateStream.send('This is from main()');
  }

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

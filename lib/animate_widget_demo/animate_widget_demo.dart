import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimateWidgetDemo extends StatefulWidget {
  _AnimateWidgetDemotate createState() => new _AnimateWidgetDemotate();
}

class _AnimateWidgetDemotate extends State<AnimateWidgetDemo> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    animation = new Tween<double>(begin: 0.0, end: 100.0).animate(controller);
    // ..addListener(() {
    //     setState(() {
    //               });
    // });
    controller.forward();
    Ticker ticker = Ticker((Duration t) {})..start();
  }

  void _animate() {
    if (controller.status == AnimationStatus.completed) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimateWidgetDemo')),
      body: new AnimatedZoomLogo(animation: animation),
      floatingActionButton: FloatingActionButton(
        onPressed: _animate,
        child: Icon(Icons.refresh),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedZoomLogo extends AnimatedWidget {
  AnimatedZoomLogo({Key key, Animation<double> animation}) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }
}

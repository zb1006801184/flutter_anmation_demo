/*
 * @Description: 
 * @Author: zhubiao
 * @Date: 2022-03-14 15:31:03
 */
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class AnimateWidgetDemo extends StatefulWidget {
  _AnimateWidgetDemotate createState() => new _AnimateWidgetDemotate();
}

class _AnimateWidgetDemotate extends State<AnimateWidgetDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 100.0).animate(controller);
    // ..addListener(() {
    //     setState(() {
    //               });
    // });
    controller.forward();
    // Ticker ticker = Ticker((Duration t) {
    //   print('fps');
    // })
    //   ..start();
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
      body:
          //  Center(child: Container(
          //   margin:  EdgeInsets.symmetric(vertical: 10.0),
          //   height: animation.value,
          //   width: animation.value,
          //   child:  FlutterLogo(),
          // ),),
          AnimatedZoomLogo(animation: animation),
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
  late final Animation<double> animation;
  AnimatedZoomLogo({Key? key, required this.animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

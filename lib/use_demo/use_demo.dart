/*
 * @Description: 
 * @Author: zhubiao
 * @Date: 2022-03-21 15:17:33
 */

import 'dart:math';

import 'package:flutter/material.dart';

class UseDemo extends StatefulWidget {
  const UseDemo({Key? key}) : super(key: key);

  @override
  State<UseDemo> createState() => _UseDemoState();
}

class _UseDemoState extends State<UseDemo> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  void _animate() {
    setState(() {
      _controller.status == AnimationStatus.completed
          ? _controller.reverse()
          : _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('使用示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _transformWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animate,
        child: Icon(Icons.ads_click),
      ),
    );
  }

  ///翻转动画
  Widget _transformWidget() {
    return AnimatedTransformWidget(
      Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.black,
      ),
      animation: _animation,
    );
  }
}

class AnimatedTransformWidget extends AnimatedWidget {
  final Widget fontWidget;
  final Widget backWidget;
  AnimatedTransformWidget(
    this.fontWidget,
    this.backWidget, {
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        // ..rotateY(pi * animation.value),
        ..rotateX(pi * animation.value),
      child: animation.value <= 0.5 ? fontWidget : backWidget,
    );
  }
}

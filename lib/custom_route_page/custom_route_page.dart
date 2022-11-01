/*
 * @Description: 动画路由
 * @Author: zhubiao
 * @Date: 2022-03-24 15:04:12
 */
import 'dart:math';

import 'package:flutter/material.dart';

enum TransitionsType {
  ///从左到右
  leftToRight,

  ///从右到左
  rightToLeft,

  ///从上到下
  topToBottom,

  ///从下到上
  bottomToTop,

  ///缩放
  scale,

  ///透明
  fade,

  ///旋转
  rotation,

  ///上下翻转
  transformY,

  ///左右翻转
  transformX
}

class CustomRoutePage extends PageRoute {
  final Widget child;
  final TransitionsType transitionsType;
  final Widget currentPage;
  CustomRoutePage(
    this.child, {
    required this.currentPage,
    required this.transitionsType,
  }) : super();

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    switch (this.transitionsType) {
      case TransitionsType.leftToRight:
        return leftToRight(animation);
      case TransitionsType.rightToLeft:
        return rightToLeft(animation);
      case TransitionsType.topToBottom:
        return topToBottom(animation);
      case TransitionsType.bottomToTop:
        return bottomToTop(animation);
      case TransitionsType.scale:
        return scale(animation);
      case TransitionsType.fade:
        return fade(animation);
      case TransitionsType.rotation:
        return rotation(animation);
      case TransitionsType.transformY:
        return transformY(animation, child);
      case TransitionsType.transformX:
        return transformX(animation, child);
      default:
    }
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
          .animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
      child: this.child,
    );
  }

  Widget leftToRight(Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
          .animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
      child: this.child,
    );
  }

  Widget rightToLeft(Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
          .animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
      child: this.child,
    );
  }

  Widget topToBottom(Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
          .animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
      child: this.child,
    );
  }

  Widget bottomToTop(Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
          .animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
      child: this.child,
    );
  }

  ///缩放
  Widget scale(Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: this.child,
    );
  }

  ///透明

  Widget fade(Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: this.child,
    );
  }

  ///旋转

  Widget rotation(Animation<double> animation) {
    return RotationTransition(
      turns: animation,
      child: this.child,
    );
  }

  Widget transformY(Animation<double> animation, Widget backWidget) {
    return AnimatedTransformYWidget(
      currentPage,
      this.child,
      animation: animation,
    );
  }

  Widget transformX(Animation<double> animation, Widget backWidget) {
    return AnimatedTransformXWidget(
      currentPage,
      this.child,
      animation: animation,
    );
  }
}

class AnimatedTransformYWidget extends AnimatedWidget {
  final Widget fontWidget;
  final Widget backWidget;

  AnimatedTransformYWidget(
    this.fontWidget,
    this.backWidget, {
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Container(
      color: Colors.white,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(pi * animation.value),
        child: animation.value <= 0.5
            ? fontWidget
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(pi),
                child: backWidget,
              ),
      ),
    );
  }
}

class AnimatedTransformXWidget extends AnimatedWidget {
  final Widget fontWidget;
  final Widget backWidget;

  AnimatedTransformXWidget(
    this.fontWidget,
    this.backWidget, {
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Container(
      color: Colors.white,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateX(pi * animation.value),
        child: animation.value <= 0.5
            ? fontWidget
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateX(pi),
                child: backWidget,
              ),
      ),
    );
  }
}

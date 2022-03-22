/*
 * @Description: 
 * @Author: zhubiao
 * @Date: 2022-03-14 15:31:03
 */
import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainrerPage extends StatefulWidget {
  @override
  _CustomPainrerPageState createState() => _CustomPainrerPageState();
}

class _CustomPainrerPageState extends State<CustomPainrerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 4000))
          ..repeat()
          ..addListener(() {
            // print('object');
            setState(() {});
          });

    // _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('画板'),
        ),
        body: Center(
          child: Container(
            // width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: DemoPainter(
                0, _controller.value * pi * 2,
                // Tween(begin: pi * 1.5, end: pi * 3.5)
                //     .chain(CurveTween(curve: Interval(0.5, 1.0)))
                //     .evaluate(_controller),
                // sin(_controller.value * pi) * pi
                _controller.value,
              ),
            ),
          ),
        ));
  }
}

class DemoPainter extends CustomPainter {
  final double _arcStart;
  final double _arcSweep;
  final double value;

  DemoPainter(this._arcStart, this._arcSweep, this.value);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue //画笔颜色
      ..strokeCap = StrokeCap.round //线未形状
      ..strokeWidth = 4.0 //线宽
      ..style = PaintingStyle.stroke; //是否填充
    Path path = Path();

        canvas.translate(0, 50);

    //画圆
    var rect = Rect.fromCenter(center: Offset(0, 0), width: 40, height: 40);
    path..arcTo(rect, _arcStart, _arcSweep, true);
    canvas.drawPath(path, paint);

    //划对号
    path.reset();
    canvas.translate(-10, 50);
    value <= 0.5
        ? path.relativeLineTo(10 * (value) * 2, 10 * (value) * 2)
        : path.relativeLineTo(10, 10);
    if (value > 0.5)
      path.relativeLineTo(20 * (value - 0.5) * 2, -20 * (value - 0.5) * 2);
    canvas.drawPath(path, paint);
    path.close();

    //开屏动画
    path.reset();
    canvas.translate(0, 100);
    path
      ..relativeMoveTo(0, 20)
      ..relativeLineTo(-30, 60)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();
    for (int i = 0; i < 9; i++) {
      canvas.drawPath(
          path.transform(Matrix4.rotationZ(i * pi / 4.5 * value).storage), paint);
    }
  }

  //是否重绘
  @override
  bool shouldRepaint(DemoPainter other) {
    return true;
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainrerPage extends StatefulWidget {
  @override
  _CustomPainrerPageState createState() => _CustomPainrerPageState();
}

class _CustomPainrerPageState extends State<CustomPainrerPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
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
            width: 50,
            height: 50,
            child: CustomPaint(
              painter: DemoPainter(0, _controller.value * pi * 2
                  // Tween(begin: pi * 1.5, end: pi * 3.5)
                  //     .chain(CurveTween(curve: Interval(0.5, 1.0)))
                  //     .evaluate(_controller),
                  // sin(_controller.value * pi) * pi
                  ),
            ),
          ),
        ));
  }
}

class DemoPainter extends CustomPainter {
  final double _arcStart;
  final double _arcSweep;

  DemoPainter(this._arcStart, this._arcSweep);

  @override
  void paint(Canvas canvas, Size size) {
    double side = [size.width, size.height].reduce(min);
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
        Offset.zero & Size(side, side), _arcStart, _arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(DemoPainter other) {
    return _arcStart != other._arcStart || _arcSweep != other._arcSweep;
  }
}

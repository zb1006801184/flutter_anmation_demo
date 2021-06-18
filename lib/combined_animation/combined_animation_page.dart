import 'package:flutter/material.dart';

class CombinedAnimationPage extends StatefulWidget {
  @override
  _CombinedAnimationPageState createState() => _CombinedAnimationPageState();
}

class _CombinedAnimationPageState extends State<CombinedAnimationPage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _width;
  Animation<double> _height;
  Animation<Color> _color;
  Animation<double> _border;
  Animation<BorderRadius> _borderRadius;

  void _play() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _width = Tween<double>(
      begin: 100,
      end: 300,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.ease,
        ),
      ),
    );

    _height = Tween<double>(
      begin: 100,
      end: 300,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.ease,
        ),
      ),
    );

    _color = ColorTween(
      begin: Colors.blue,
      end: Colors.yellow,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          0.6,
          curve: Curves.ease,
        ),
      ),
    );

    _borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(150.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.6,
          0.8,
          curve: Curves.ease,
        ),
      ),
    );

    _border = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 1.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('交织动画')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Container(
              width: _width.value,
              height: _height.value,
              decoration: BoxDecoration(
                color: _color.value,
                borderRadius: _borderRadius.value,
                border: Border.all(
                    // width: _border.value,
                    // color: Colors.orange,
                    ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _play,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AnimaterBuilderDemo extends StatefulWidget {
  const AnimaterBuilderDemo({Key key}) : super(key: key);

  @override
  _AnimaterBuilderDemoState createState() => _AnimaterBuilderDemoState();
}

class _AnimaterBuilderDemoState extends State<AnimaterBuilderDemo> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    _animation = new Tween<double>(begin: 0.0, end: 100.0).animate(_animationController);
  }

  void _animate() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _animate,
      ),
      appBar: AppBar(title: Text("AnimaterBuilderDemo")),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return Container(
              width: _animation.value,
              height: _animation.value,
              child: FlutterLogo(),
            );
          },
        ),
      ),
    );
  }
}

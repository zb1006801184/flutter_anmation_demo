
import 'package:flutter/material.dart';

class TweenAnimatedBuilderDemo extends StatefulWidget {
  const TweenAnimatedBuilderDemo({Key? key}) : super(key: key);

  @override
  _TweenAnimatedBuilderDemoState createState() => _TweenAnimatedBuilderDemoState();
}

class _TweenAnimatedBuilderDemoState extends State<TweenAnimatedBuilderDemo> {
  double _value = 50.0;
  void _animate() {
    setState(() {
      _value = _value == 50.0 ? 0.0 : 50.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TweenAnimatedBuilder'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: _value),
          duration: Duration(seconds: 1),
          builder: (BuildContext context, double value, Widget? child) {
            return Container(
              width: value,
              height: value,
              child: child,
            );
          },
          child: FlutterLogo(size: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animate,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

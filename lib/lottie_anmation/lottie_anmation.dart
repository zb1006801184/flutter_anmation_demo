/*
 * @Description: 
 * @Author: zhubiao
 * @Date: 2022-03-25 10:28:58
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class LottieAnmation extends StatefulWidget {
  const LottieAnmation({Key? key}) : super(key: key);

  @override
  State<LottieAnmation> createState() => _LottieAnmationState();
}

class _LottieAnmationState extends State<LottieAnmation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('lottie anmation'),
      ),
      body: Lottie.asset(
        'assets/lottie/transitions/data.json',
        width: double.infinity,
        height: double.infinity,
        repeat: true,
        fit: BoxFit.cover,
        controller: _controller,
        onLoaded: (composition) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isAnimating) return;
          !_controller.isCompleted
              ? _controller.forward()
              : _controller.animateBack(0);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}

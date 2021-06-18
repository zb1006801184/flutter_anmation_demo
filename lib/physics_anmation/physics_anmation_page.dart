import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PhysicsAnmationPage extends StatefulWidget {
  @override
  _PhysicsAnmationPageState createState() => _PhysicsAnmationPageState();
}

class _PhysicsAnmationPageState extends State<PhysicsAnmationPage> {
  // 球心高度
  double y = 70.0;
  // Y 轴速度
  double vy = -10.0;
  // 重力
  double gravity = 0.1;
  // 地面反弹力
  double bounce = -0.5;
  // 球的半径
  double radius = 50.0;
  // 地面高度
  final double height = 500;
  //回落次数
  int count = 0;

  // 下落方法
  void _fall(_) {
    if (count >= 10) return;

    y += vy;
    vy += gravity;

    // 如果球体接触到地面，根据地面反弹力改变球体的 Y 轴速度
    if (y + radius > height) {
      y = height - radius;
      vy *= bounce;
      count++;
    } else if (y - radius < 0) {
      y = 0 + radius;
      vy *= bounce;
    }

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // 使用一个 Ticker 在每次更新界面时运行球体下落方法
    Ticker(_fall)..start();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('物理动画')),
      body: Column(
        children: <Widget>[
          Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: y - radius,
                  left: screenWidth / 2 - radius,
                  child: Container(
                    width: radius * 2,
                    height: radius * 2,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container(color: Colors.blue)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

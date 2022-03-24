/*
 * @Description: 
 * @Author: zhubiao
 * @Date: 2022-03-14 15:31:03
 */
import 'package:flutter/material.dart';
///隐式动画
class ImplicitAnmationPage extends StatefulWidget {
  @override
  _ImplicitAnmationPageState createState() => _ImplicitAnmationPageState();
}

class _ImplicitAnmationPageState extends State<ImplicitAnmationPage> {
  // 初始的属性值
  double size = 100;
  double raidus = 25;
  Color color = Colors.red;

  double opacity = 0.0;
  EdgeInsetsGeometry padding = EdgeInsets.all(20);
  double bottom = 0.0;

  void _animate() {
    setState(() {
      size = size == 100 ? 200 : 100;
      raidus = raidus == 25 ? 100 : 25;
      color = color == Colors.red ? Colors.greenAccent : Colors.red;
      opacity = opacity == 0.0 ? 1.0 : 0.0;
      padding = padding.vertical == 40 ? EdgeInsets.all(0) : EdgeInsets.all(20);
      bottom = bottom == 100.0 ? 0.0 : 100.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('隐式动画')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              children: [
                AnimatedContainer(
                  width: size,
                  height: size,
                  curve: Curves.easeIn,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(raidus)),
                  duration: Duration(milliseconds: 300),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: opacity,
                  child: Container(width: 50, height: 50, color: Colors.red),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 300),
                    padding: padding,
                    child: Container(color: Colors.grey, width: double.infinity, height: double.infinity),
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              left: bottom,
              bottom: bottom,
              child: Container(height: 50, width: 50, color: Colors.black),
              duration: Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animate,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

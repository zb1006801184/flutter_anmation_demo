
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///显式动画
class ExplicitAnmationPage extends StatefulWidget {
  @override
  _ExplicitAnmationPageState createState() => _ExplicitAnmationPageState();
}

class _ExplicitAnmationPageState extends State<ExplicitAnmationPage>
    with TickerProviderStateMixin {
  late Animation<Offset> anmationSlideTransition;
  late AnimationController controllSlideTransition;

  late Animation<double> anmationFadeTransition;
  late AnimationController controllFadeTransition;

  late Animation<double> anmationRotationTransition;
  late AnimationController controllRotationTransition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SlideTransition
    controllSlideTransition = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    // final ss = CurvedAnimation(parent: controllSlideTransition, curve: Curves.easeIn);
    anmationSlideTransition = Tween(begin: Offset.zero, end: Offset(1.0, 0.0))
        .animate(controllSlideTransition);

    //FadeTransition
    controllFadeTransition =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    anmationFadeTransition =
        Tween(begin: 1.0, end: 0.0).animate(controllFadeTransition);

    //RotationTransition
    controllRotationTransition =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    anmationRotationTransition =
        Tween(begin: 0.0, end: 1.0).animate(controllRotationTransition);
  }

  void _animate() {
    controllSlideTransition.status == AnimationStatus.completed
        ? controllSlideTransition.reset()
        : controllSlideTransition.forward();

    controllFadeTransition.status == AnimationStatus.completed
        ? controllFadeTransition.reset()
        : controllFadeTransition.forward();

    controllRotationTransition.status == AnimationStatus.completed
        ? controllRotationTransition.reset()
        : controllRotationTransition.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('显示动画')),
      body: Center(
        child: Column(
          children: [
            SlideTransition(
              position: anmationSlideTransition,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
            FadeTransition(
              opacity: anmationFadeTransition,
              child: Container(
                color: Colors.blue,
                width: 100.0,
                height: 100.0,
              ),
            ),
            RotationTransition(
              turns: anmationRotationTransition,
              child: Container(width: 100, height: 100, color: Colors.red),
            )
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

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //头像部分
    var headPart = Stack(
      // alignment: FractionalOffset(0.5, 1.5),
      children: <Widget>[
        Positioned(
          child: Container(
            width: 81.0,
            height: 81.0,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(40.5), border: Border.all(color: Colors.pinkAccent, width: 5.0, style: BorderStyle.solid)),
            child: ClipOval(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  print('点击了图片');
                },
                child: Container(
                  child: Image.network(
                    'http://oss.img.2or3m.com/ayy_common/php/20210428/bbkhWpkj6m.jpg',
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 60,
            child: Container(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                width: 81,
                // color: Colors.black38,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(17.5), color: Colors.white, boxShadow: [
                  BoxShadow(
                    blurRadius: 4, //阴影范围
                    spreadRadius: 1, //阴影浓度
                    color: Colors.pinkAccent, //阴影颜色
                  ),
                ]),
                // height: 35.0,
                child: new GestureDetector(
                  child: Container(
                    child: Center(
                      child: Text(
                        '冯亮亮',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('object');
                  },
                ))),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: Center(
        child: Container(width: 100, height: 100, child: headPart),
      ),
    );
  }
}

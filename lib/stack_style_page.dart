import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_floating_action_button_location.dart';

class StackStylePage extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

//应用页面状态实现类
class AppState extends State<StackStylePage> {
  //当前选中页面索引
  var _currentIndex = 0;
  MyCenterDockedFloatingActionButtonLocation
      myCenterDockedFloatingActionButtonLocation =
      MyCenterDockedFloatingActionButtonLocation();


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
      appBar: AppBar(
        title: Text("StackStyle"),
      ),
      //底部导航按钮
      body:   Stack(
        children: <Widget>[
          Column(children: <Widget>[
            Expanded(
                child: Container(),),
            Container(
              height: 55,
            ),
          ]),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xf000000),
                      blurRadius: 4.0,
                      spreadRadius: 4.0,
                      offset: Offset(0, 2.0),
                    ),
                  ],
                ),
                child: new TabBar(
                  isScrollable: false,
                  indicatorColor: Colors.transparent,
                  labelColor: Color(0xFFF54343),
                  labelPadding: EdgeInsets.all(0),
                  unselectedLabelColor: Colors.black,
                  tabs: <Widget>[
                    new Tab(
                      text: "主页",
                      icon: new Icon(Icons.home),
                    ),
                    new Tab(
                      text: "主页",
                      icon: new Icon(Icons.home),
                    ),
                   //中间多一个占位的
                   Container(),
                    new Tab(
                      text: "主页",
                      icon: new Icon(Icons.home),
                    ),
                    new Tab(
                      text: "主页",
                      icon: new Icon(Icons.home),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: GestureDetector(
                child: Center(
                  child: Container(
                    height: 59,
                    width: 75,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Image.asset(
                      "images/icon_add.png",
                      height: 50,
                      width: 46,
                    ),
                  ),
                ),
                onTap: () {
                },
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}

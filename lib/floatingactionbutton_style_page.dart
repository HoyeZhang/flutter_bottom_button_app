import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_floating_action_button_location.dart';

class FloatingActionButtonStylePage extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

//应用页面状态实现类
class AppState extends State<FloatingActionButtonStylePage> {
  //当前选中页面索引
  var _currentIndex = 0;
  MyCenterDockedFloatingActionButtonLocation
      myCenterDockedFloatingActionButtonLocation =
      MyCenterDockedFloatingActionButtonLocation();

  //根据当前索引返回不同的页面
  currentPage() {
    switch (_currentIndex) {
      case 0:

      case 1:

      case 2:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //底部导航按钮
      appBar: AppBar(title: Text("FloatingActionButtonStyle"),),
      bottomNavigationBar: new BottomNavigationBar(
        //通过fixedColor设置选中item的颜色
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        //当前页面索引
        currentIndex: _currentIndex,
        //按下后设置当前页面索引
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
        //底部导航按钮项
        items: [
          //导航按钮项传入文本及图标
          new BottomNavigationBarItem(
              title: new Text(
                '1',
                style: TextStyle(
                    color: _currentIndex == 0
                        ? Color(0xFFF54343)
                        : Color(0xff999999) //0x 后面开始 两位FF表示透明度16进制 后面是颜色
                    ),
              ),
              //判断当然索引做图片切换显示
              icon: _currentIndex == 0
                  ? Icon(Icons.home, color: Color(0xFFF54343))
                  : Icon(Icons.home, color: Color(0xff999999))),
          new BottomNavigationBarItem(
              title: new Text(
                '2',
                style: TextStyle(
                    color: _currentIndex == 1
                        ? Color(0xFFF54343)
                        : Color(0xff999999)),
              ),
              //判断当然索引做图片切换显示
              icon: _currentIndex == 1
                  ? Icon(Icons.home, color: Color(0xFFF54343))
                  : Icon(Icons.home, color: Color(0xff999999))),
          new BottomNavigationBarItem(
              title: new Text(
                'x',
                style: TextStyle(
                    color: _currentIndex == 2
                        ? Color(0xFFF54343)
                        : Color(0xff999999)),
              ),
              //判断当然索引做图片切换显示
              icon: _currentIndex == 2
                  ? Icon(Icons.home, color: Color(0xFFF54343))
                  : Icon(Icons.home, color: Color(0xff999999))),
          new BottomNavigationBarItem(
              title: new Text(
                '3',
                style: TextStyle(
                    color: _currentIndex == 3
                        ? Color(0xFFF54343)
                        : Color(0xff999999)),
              ),
              //判断当然索引做图片切换显示
              icon: _currentIndex == 3
                  ? Icon(Icons.home, color: Color(0xFFF54343))
                  : Icon(Icons.home, color: Color(0xff999999))),
          new BottomNavigationBarItem(
              title: new Text(
                '4',
                style: TextStyle(
                    color: _currentIndex == 4
                        ? Color(0xFFF54343)
                        : Color(0xff999999)),
              ),
              //判断当然索引做图片切换显示
              icon: _currentIndex == 4
                  ? Icon(Icons.home, color: Color(0xFFF54343))
                  : Icon(Icons.home, color: Color(0xff999999))),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 0,
        child: Image.asset(
          "images/icon_add.png",
        ),
      ),
      floatingActionButtonLocation: myCenterDockedFloatingActionButtonLocation,

      //中间显示当前页面
      body: currentPage(),
    );
  }
}

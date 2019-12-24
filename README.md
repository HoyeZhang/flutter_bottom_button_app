# flutter_bottom_button_app flutter底部菜单与悬浮按钮
- flutter 并没有提供Widget实现底部菜单及中间的悬浮按钮，借由FloatingActionButton实现的定义的几个位置都是固定的跨站性不高，可借Stack或修改FloatingActionButton源码实现该功能。
## Stack方式实现
- Stack实现的思想是虚浮按钮固定显示于底部，底部菜单中间多出一个位置给悬浮按钮。
<pre>
 Stack(
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
</pre>
![](https://github.com/ajjoke/flutter_bottom_button_app/blob/master/images/001.png?raw=true)
## FloatingActionButton 方式
-  FloatingActionButton的位置由floatingActionButtonLocation:  决定，点进去源码可看到
<pre>
class _CenterDockedFloatingActionButtonLocation extends _DockedFloatingActionButtonLocation {
  const _CenterDockedFloatingActionButtonLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width) / 2.0;
	//getDockedY 决定y轴位置
    return Offset(fabX, getDockedY(scaffoldGeometry));
  }

  @override
  String toString() => 'FloatingActionButtonLocation.centerDocked';
}

</pre>
- 也就是我们修改getDockedY 方法即可，修改后代码如下
<pre>
class MyCenterDockedFloatingActionButtonLocation extends _DockedFloatingActionButtonLocation {
  const MyCenterDockedFloatingActionButtonLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width) / 2.0;
    return Offset(fabX, getDockedY(scaffoldGeometry));
  }

  @override
  String toString() => 'FloatingActionButtonLocation.centerDocked';
}



abstract class _DockedFloatingActionButtonLocation extends FloatingActionButtonLocation {
  const _DockedFloatingActionButtonLocation();

  // Positions the Y coordinate of the [FloatingActionButton] at a height
  // where it docks to the [BottomAppBar].
  @protected
  double getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;
	
	//主要是修改了这行
    double fabY = contentBottom  -4 ;
    // The FAB should sit with a margin between it and the snack bar.
    if (snackBarHeight > 0.0)
      fabY = math.min(fabY, contentBottom - snackBarHeight - fabHeight - kFloatingActionButtonMargin);
    // The FAB should sit with its center in front of the top of the bottom sheet.
    if (bottomSheetHeight > 0.0)
      fabY = math.min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);

    final double maxFabY = scaffoldGeometry.scaffoldSize.height - fabHeight;
    return math.min(maxFabY, fabY);
  }
}

</pre>
- 由上面那个类应用到floatingActionButtonLocation即可
<pre>
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

</pre>
![](https://github.com/ajjoke/flutter_bottom_button_app/blob/master/images/002.png?raw=true)
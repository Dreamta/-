import 'package:bt_system/view/menu/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class CustomWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        color: Colors.blueGrey,
        width: 1,
        child: Row(
          children: [
            LeftSide(),
            Expanded(child: RightSide()),
          ],
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // 这里可以添加您的菜单栏组件
            Expanded(
                child: Column(
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(color: Colors.amber),
                  child: BTMenuBar(),
                ),
                Expanded(child: Container())
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class RightSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[100]),
      child: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(child: MoveWindow()),
                WindowButtons(),
              ],
            ),
          ),
          // 这里是您的应用内容
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

// 您可以自定义这些颜色以匹配您的应用主题
final buttonColors = WindowButtonColors(
  iconNormal: Colors.black,
  mouseOver: Colors.blue[700],
  mouseDown: Colors.blue[800],
  iconMouseOver: Colors.white,
  iconMouseDown: Colors.white,
);

final closeButtonColors = WindowButtonColors(
  mouseOver: Colors.red[700],
  mouseDown: Colors.red[800],
  iconNormal: Colors.black,
  iconMouseOver: Colors.black,
);

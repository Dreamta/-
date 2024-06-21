import 'dart:io';

import 'package:bt_system/global.dart';
import 'package:bt_system/view/windows/custom_window.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async {
  runApp(const BtSystem());
  doWhenWindowReady(() {
    const initialSize = Size(670, 700); // 设置一个初始大小
    appWindow.size = initialSize;
    appWindow.minSize = initialSize;
    appWindow.alignment = Alignment.center; // 可以设置窗口在屏幕中的位置
    appWindow.title = "BT";
    appWindow.show(); // 显示窗口
  });
}

class BtSystem extends StatefulWidget {
  const BtSystem({super.key});

  @override
  State<StatefulWidget> createState() => _BtSystemState();
}

class _BtSystemState extends State<BtSystem> {
  late Future initFuture;
  @override
  initState() {
    super.initState();
    initFuture = Global.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
            future: initFuture,
            builder: (context, snapshot) {
              sleep(Duration.zero);
              if (snapshot.connectionState == ConnectionState.done) {
                return CustomWindow();
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}

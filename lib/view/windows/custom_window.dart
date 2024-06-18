import 'package:bt_system/exception/database_exception.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:bt_system/module/teacher_module.dart';
import 'package:bt_system/view/menu/menu_bar.dart';
import 'package:bt_system/view/windows/left_side.dart';
import 'package:bt_system/view/windows/right_side.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class CustomWindow extends StatefulWidget {
  const CustomWindow({super.key});

  @override
  State<StatefulWidget> createState() => _CustomWindowState();
}

class _CustomWindowState extends State<CustomWindow> {
  List<Moudle> _rightParam = [];
  List<Moudle> _leftParam = [];
  Moudle? rightListOwner;
  int mode = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        color: Colors.blueGrey,
        width: 1,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: BTMenuBar(
                    //传送一个列表进去接受数据，返回后刷新页面，判断列表内数据类型，若为空则弹窗提醒
                    onTap: ({List<Moudle> moudles = const [], int site = 1}) {
                      mode = site;
                      switch (site) {
                        case 2:
                          {
                            _leftParam = [];
                            _rightParam = moudles;
                            break;
                          }
                        default:
                          {
                            _leftParam = moudles;
                            _rightParam = [];
                          }
                      }

                      /// 左边栏没有数据，右边栏也不应该有
                      if (moudles.isEmpty) {
                        _rightParam = [];
                      }
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: 2 == mode
                      ? const SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 4, child: Center(child: Text('日期'))),
                              Expanded(
                                  flex: 2, child: Center(child: Text('星期'))),
                              Expanded(
                                  flex: 3, child: Center(child: Text('时间'))),
                              Expanded(
                                  flex: 3, child: Center(child: Text('小时'))),
                              Expanded(
                                  flex: 3, child: Center(child: Text('科目'))),
                              Expanded(
                                  flex: 3, child: Center(child: Text('课类'))),
                              Expanded(
                                  flex: 3, child: Center(child: Text('老师'))),
                              Expanded(
                                  flex: 3, child: Center(child: Text('年级'))),
                            ],
                          ),
                        )
                      : Container(),
                )
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  /// 左侧边栏
                  LeftSide(
                    cardOnTap: _refreshSelf,
                    moudleList: _leftParam,
                  ),

                  /// 右侧边栏
                  Expanded(
                      child: RightSide(
                    list: _rightParam,
                    listOwner: _leftParam.isEmpty ? null : rightListOwner,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _refreshSelf({List<Moudle> moudles = const [], required Moudle owner}) {
    _rightParam = moudles;
    rightListOwner = owner;
    setState(() {});
  }

  // _showAllCourses() async {}
}

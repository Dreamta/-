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
  // 应该允许为null,以区分没有找到数据（或在返回空列表时抛出异常）
  // List<StudentModule>? students;
  // List<CourseMoudle>? courses;
  // List<TeacherModule>? teachers;

  List<Moudle>? _rightParam;
  List<Moudle>? _leftParam;
  @override
  Widget build(BuildContext context) {
    // if (students != null) {
    //   rightParam = students!;
    //   rightParam = students!;
    // } else if (courses != null) {
    //   rightParam = courses!;
    //   leftParam = students!;
    // } else if (teachers != null) {
    //   rightParam = teachers!;
    //   leftParam = students!;
    // }
    return Scaffold(
      body: WindowBorder(
        color: Colors.blueGrey,
        width: 1,
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: BTMenuBar(
                    //传送一个列表进去接受数据，返回后刷新页面，判断列表内数据类型，若为空则弹窗提醒
                    // showAllCoures: _showAllCourses,
                    onTap: (List<Moudle> list) {
                      _leftParam = list;
                      // function();
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: LeftSide(
                    cardOnTap: _refreshSelf,
                    // cardOnTap: (moudle) => _findCourses(moudle),
                    moudleList: _leftParam ?? [],
                  ),
                )
              ],
            ),
            Expanded(
                child: RightSide(
              list: _rightParam,
            )),
          ],
        ),
      ),
    );
  }

  _refreshSelf(List<Moudle> list) {
    _rightParam = list;
    setState(() {});
  }

  _showAllCourses() async {}
}

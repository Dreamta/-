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
  List<StudentModule>? students;
  List<CourseMoudle>? courses;
  List<TeacherModule>? teachers;
  @override
  Widget build(BuildContext context) {
    List? rightParam;
    List? leftParam;

    if (students != null) {
      rightParam = students!;
      rightParam = students!;
    } else if (courses != null) {
      rightParam = courses!;
      leftParam = students!;
    } else if (teachers != null) {
      rightParam = teachers!;
      leftParam = students!;
    }
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
                    showAllCoures: _showAllCourses,
                  ),
                ),
                Expanded(
                  child: LeftSide(
                    cardOnTap: (moudle) => _findCourses(moudle),
                  ),
                )
              ],
            ),
            Expanded(
                child: RightSide(
              list: rightParam,
            )),
          ],
        ),
      ),
    );
  }

  _showAllCourses() async {}
  _findCourses(Moudle moudle) async {
    StudentModule e = moudle as StudentModule;
    courses = (await Global.database
            .findCoursesByStudent(e.name, e.registGrade, e.registYear))
        .map((e) => CourseMoudle.fromDatabase(e))
        .toList();
    setState(() {});
  }
}

import 'package:bt_system/cache.dart';
import 'package:bt_system/excel/init_info.dart';
import 'package:bt_system/exception/database_exception.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:bt_system/module/teacher_module.dart';
import 'package:flutter/material.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';

class BTMenuBar extends StatefulWidget {
  Function({List<Moudle> moudles, int site}) onTap;
  BTMenuBar({super.key, required this.onTap});

  @override
  State<BTMenuBar> createState() => _BTMenuBarState();
}

class _BTMenuBarState extends State<BTMenuBar> {
  // 初始化菜单列表
  late final List<PlutoMenuItem> whiteHoverMenus;
  late bool dataBaseHasInit;
  // List<CourseMoudle>? courseMoudles;
  //  List<StudentModule>? students;
  // List<TeacherModule>? teachers;
  @override
  void initState() {
    super.initState();
    dataBaseHasInit = true;
    Cache.getInstence().get<bool>(DATABASE_HAS_INIT) ?? false;
    whiteHoverMenus = _makeMenus(context);
  }

  List<PlutoMenuItem> _makeMenus(BuildContext context) {
    return [
      PlutoMenuItem(
        title: '学生',
        // 定义子菜单
        children: [
          PlutoMenuItem(title: '初始化', onTap: _initStudentInfoFromTable),
          // 如果数据库未初始化，需要初始化再添加
          PlutoMenuItem(title: '添加学生', onTap: () {}),
          PlutoMenuItem(
              title: '查看现有学生',
              enable: dataBaseHasInit,
              onTap: () async {
                _showAllStudents();
              }),
          PlutoMenuItem(
              title: '清除所有学生',
              enable: dataBaseHasInit,
              onTap: _deleteAllStudents)
        ],
      ),
      PlutoMenuItem(title: '课程', children: [
        PlutoMenuItem(
          title: '查看所有课程',
          onTap: () async {
            _findAllCourses();
          },
        ),
        PlutoMenuItem(
          title: '清空课程',
          onTap: () async {
            Future future = Global.database.deleteAllCourses();
            future.then((value) => print('ok'));
          },
        ),
      ]),
      PlutoMenuItem(title: '老师', children: [
        PlutoMenuItem(
          title: '清空老师',
          onTap: () async {
            await Global.database.deleteAllTeachers();
          },
        ),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: PlutoMenuBar(
          mode: PlutoMenuBarMode.tap,
          menus: _makeMenus(context),
        ));
  }

  // 返回所有学生信息
  // Future<List<Moudle>?>
  _showAllStudents() async {
    List<StudentModule> students = [];
    try {
      students = (await Global.database.getAllStudents())
          .map((e) => StudentModule.fromDatabase(e))
          .toList();
    } on TableNotExistException catch (e) {
      print(e.message);
    }
    widget.onTap(moudles: students);

    // return students;
  }

  _findAllCourses() async {
    List<CourseMoudle> courses = [];
    try {
      courses = (await Global.database.getAllCourses())
          .map((e) => CourseMoudle.fromDatabase(e))
          .toList();
    } catch (e) {
      print(e);
    }
    widget.onTap(moudles: courses, site: 2);
  }

  // _findCourses(StudentModule moudle) async {
  //   (await Global.database.findCoursesByStudent(
  //           moudle.name, moudle.registGrade, moudle.registYear))
  //       .map((e) => CourseMoudle.fromDatabase(e))
  //       .toList();
  // }

  // 从一个表单初始化学生信息
  _initStudentInfoFromTable() async {
    try {
      await initInfoFromExcel();
      setState(() {
        dataBaseHasInit = true;
      });
      Cache.getInstence().setBool(DATABASE_HAS_INIT, true);
    } catch (e) {
      print(e);
    }
  }

  /// 删除所有学生
  _deleteAllStudents() async {
    await Global.database.deleteAllStudents();
    widget.onTap();
  }
}

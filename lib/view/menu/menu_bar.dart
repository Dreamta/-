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
  /// moudles:选择要刷新出的列表数据，site：选择要显示在左侧栏还是右侧栏
  final Function({List<Moudle> moudles, int site}) onTap;
  const BTMenuBar({super.key, required this.onTap});

  @override
  State<BTMenuBar> createState() => _BTMenuBarState();
}

class _BTMenuBarState extends State<BTMenuBar> {
  // 初始化菜单列表
  late final List<PlutoMenuItem> whiteHoverMenus;
  late bool dataBaseHasInit;

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
          PlutoMenuItem.divider(height: 1),
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
            await _findAllCourses();
          },
        ),
        PlutoMenuItem(
          title: '查看课程',
          onTap: () async {
            // 7418 12 2024 刘博文
            await Global.database.findStudentCourse(
                stuName: '刘博文',
                registGrade: GRADE.grade12,
                registYear: 2024,
                courseId: 7418);
          },
        ),
        PlutoMenuItem(
          title: '清空课程',
          onTap: () async {
            Future future = Global.database.deleteAllCourses();
          },
        ),
      ]),
      PlutoMenuItem(title: '老师', children: [
        PlutoMenuItem(
          title: '查看老师',
          onTap: () async {
            await _showAllTeachers();
          },
        ),
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
        width: 170,
        child: PlutoMenuBar(
          mode: PlutoMenuBarMode.hover,
          menus: _makeMenus(context),
        ));
  }

  // 返回所有学生信息
  Future _showAllStudents() async {
    List<StudentModule> students = [];
    try {
      students = (await Global.database.getAllStudents())
          .map((e) => StudentModule.fromDatabase(e))
          .toList();
    } on TableNotExistException catch (e) {
      print(e.message);
    }
    widget.onTap(moudles: students);
  }

  Future _showAllTeachers() async {
    List<TeacherModule> teachers = [];
    try {
      teachers = (await Global.database.getAllTeachers())
          .map((e) => TeacherModule.fromDatabase(e))
          .toList();
    } catch (e) {
      print(e);
    }

    widget.onTap(moudles: teachers);
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
  void _initStudentInfoFromTable() async {
    try {
      Global.showLoadingDialog(context, initInfoFromExcel);

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
    Global.showLoadingDialog(context, Global.database.deleteAllStudents);

    widget.onTap();
  }
}

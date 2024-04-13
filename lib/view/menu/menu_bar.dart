import 'package:bt_system/cache.dart';
import 'package:bt_system/excel/init_info.dart';
import 'package:bt_system/exception/database_exception.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:flutter/material.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';

class BTMenuBar extends StatefulWidget {
  const BTMenuBar({super.key});

  @override
  State<BTMenuBar> createState() => _BTMenuBarState();
}

class _BTMenuBarState extends State<BTMenuBar> {
  // 初始化菜单列表
  late final List<PlutoMenuItem> whiteHoverMenus;
  late bool dataBaseHasInit;
  late List<CourseMoudle> courseMoudles;
  @override
  void initState() {
    super.initState();
    dataBaseHasInit = true;
    // Cache.getInstence().get<bool>(DATABASE_HAS_INIT) ?? false;
    whiteHoverMenus = _makeMenus(context);
  }

  List<PlutoMenuItem> _makeMenus(BuildContext context) {
    return [
      PlutoMenuItem(
        title: '学生',
        // 定义子菜单
        children: [
          PlutoMenuItem(title: '初始化', onTap: initStudentInfoFromTable),
          // 如果数据库未初始化，需要初始化再添加
          PlutoMenuItem(
              title: '添加学生',
              onTap: () {
                setState(() {});
              }),
          PlutoMenuItem(
              title: '查看现有学生', enable: dataBaseHasInit, onTap: showAllStudents),
          PlutoMenuItem(
              title: '清除所有学生',
              enable: dataBaseHasInit,
              onTap: deleteAllStudents)
        ],
      ),
      PlutoMenuItem(title: '课程', children: [
        PlutoMenuItem(
          title: '查看所有课程',
          onTap: () async {
            courseMoudles = await Global.database.getAllCourses();
            for (var course in courseMoudles) {
              print(course.courseType);
            }
          },
        ),
        PlutoMenuItem(
          title: '清空课程',
          onTap: () async {
            Global.database.deleteAllCourses();
          },
        ),
      ]),
      PlutoMenuItem(title: '老师', children: [
        PlutoMenuItem(
          title: '添加老师1',
          onTap: () async {
            await Global.database
                .getStudentByNameAndGrade('jiyuchen', GRADE.grade10);
          },
        ),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PlutoMenuBar(
      mode: PlutoMenuBarMode.tap,
      menus: _makeMenus(context),
    );
  }

  // 从一个表单初始化学生信息
  initStudentInfoFromTable() async {
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

  // 返回所有学生信息
  showAllStudents() async {
    List<StudentModule> students;
    try {
      students = await Global.database.getAllStudents();

      for (var stu in students) {
        print('${stu.name} ${stu.grade}');
      }
    } on TableNotExistException catch (e) {
      print(e.message);
    }
  }

  /// 删除所有学生
  deleteAllStudents() async {
    Global.database.deleteAllStudent();
  }
}

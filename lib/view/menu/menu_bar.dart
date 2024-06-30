import 'package:bt_system/cache.dart';
import 'package:bt_system/excel/init_info.dart';
import 'package:bt_system/exception/database_exception.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:bt_system/module/teacher_module.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
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
          PlutoMenuItem(
              title: '添加学生',
              onTap: () {
                String? newStuName;
                String gradeStr = GRADE.values.last.toString().split('.').last;
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                              width: 400,
                              height: 120,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: TextField(
                                          onChanged: (value) =>
                                              newStuName = value,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '学生姓名'),
                                        ),
                                      ),
                                      DropdownButton(
                                          value: gradeStr,
                                          items: GRADE.values
                                              .map((e) => DropdownMenuItem(
                                                    value: e
                                                        .toString()
                                                        .split('.')
                                                        .last,
                                                    child: Text(e
                                                        .toString()
                                                        .split('.')
                                                        .last),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              setState(() {
                                                gradeStr = value;
                                              });
                                            }
                                          }),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () => _addStudent(
                                        newStuName, gradeStrToGrade[gradeStr]!),
                                    child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: const EdgeInsets.all(5),
                                        child: const Center(
                                          child: Text(
                                            '添加学生',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        )),
                                  )
                                ],
                              )),
                        ),
                      );
                    });
              }),
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
          onTap: () async {},
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

  Future _addStudent(String? name, GRADE grade) async {
    if (name != null) {
      await Global.database.addStudent(name, grade);
      showSuccessNotification('添加成功');
    } else {
      showErrorNotification('请输入学生姓名！');
    }
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

  // 从一个表单初始化学生信息
  void _initStudentInfoFromTable() async {
    try {
      showLoadingDialog(context, initInfoFromExcel);

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
    showLoadingDialog(context, Global.database.deleteAllStudents);

    widget.onTap();
  }
}

Map<String, GRADE> gradeStrToGrade = {
  'grade7': GRADE.grade7,
  'grade8': GRADE.grade8,
  'grade9': GRADE.grade9,
  'grade10': GRADE.grade10,
  'grade11': GRADE.grade11,
  'grade12': GRADE.grade12,
};

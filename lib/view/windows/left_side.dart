import 'package:bt_system/excel/init_info.dart';
import 'package:bt_system/exception/database_exception.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:bt_system/module/teacher_module.dart';
import 'package:bt_system/view/menu/menu_bar.dart';
import 'package:flutter/material.dart';

class LeftSide extends StatefulWidget {
  final List<Moudle> moudleList;
  final Function(List<Moudle> moudle) cardOnTap;
  const LeftSide(
      {super.key, required this.cardOnTap, required this.moudleList});

  @override
  State<StatefulWidget> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  // List<StudentModule>? students;
  // List<TeacherModule>? teachers;
  // List<CourseMoudle>? courses;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
          color: Colors.white,
          child:
              // 这里可以添加您的菜单栏组件
              Column(
            children: [
              // Container(
              //     height: 30,
              //     decoration: const BoxDecoration(color: Colors.amber),
              //     child: Container()
              //     // BTMenuBar(
              //     //   showAllCoures: shouwAllCourses,
              //     // ),
              //     ),
              Container(
                height: 40,
                child: const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Row(children: [
                    // Icon(IconData(codePoint)),
                    SizedBox(
                      width: 30,
                      child: Icon(Icons.access_alarm),
                    ),
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(hintText: "搜索"),
                    ))
                  ]),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                    children: widget.moudleList
                        .map((moudle) => _nameCard(moudle, widget.cardOnTap))
                        .toList()),
              ))
            ],
          )),
    );
  }
}

showAllCourses() async {}

// 名称卡片
Widget _nameCard(Moudle moudle, Function onTap) {
  Widget? card;
  Function func = () {};
  if (moudle is StudentModule) {
    // onTap = () => Global.database.findCoursesByStudent(
    //     moudle.name, moudle.registGrade, moudle.registYear);
    card = Row(children: [
      Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          moudle.name,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Text("${gradeToInt[moudle.registGrade]!}")
    ]);
    func = () async {
      List<Moudle> list = (await Global.database.findCoursesByStudent(
              moudle.name, moudle.registGrade, moudle.registYear))
          .map((e) => CourseMoudle.fromDatabase(e))
          .toList();
      return list;
    };
  } else if (moudle is CourseMoudle) {
    card = Row(
      children: [
        Text(moudle.date),
        Text(moudle.teacher),
        Text(subTypeToString[moudle.subject]!),
        Text(courseTypeToString[moudle.courseType]!)
      ],
    );
  }
  return InkWell(
    // 点击事件：点击左侧卡片后查询对应数据，提升至父组件刷新后传递至兄弟组件
    onTap: () async {
      List<Moudle> list = await func() ?? [];
      onTap(list);
    },
    child: Container(
        width: 195,
        height: 55,
        margin: const EdgeInsets.fromLTRB(3, 1, 3, 1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Colors.grey[100]!, blurRadius: 10)],
            color: const Color.fromARGB(255, 244, 218, 165)),
        child: card ?? Container()),
  );
}

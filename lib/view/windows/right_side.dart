import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bt_system/database/database.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';

import 'package:flutter/material.dart';

class RightSide extends StatefulWidget {
  List<Moudle>? list;
  Moudle? listOwner;
  RightSide({super.key, required this.list, this.listOwner});
  @override
  State<StatefulWidget> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
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
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children:
                  widget.list?.map((e) => _nameCard(context, e)).toList() ?? [],
            ),
          )),
        ],
      ),
    );
  }

  // 名称卡片
  Widget _nameCard(BuildContext context, Moudle moudle) {
    Widget? card;
    Function func = () {};
    late Widget detailDialogContent;
    late Widget priceSetDialogContent;
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

      /// 右侧课程卡片
    } else if (moudle is CourseMoudle) {
      card = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 4,
              child: Center(child: Text(moudle.date.replaceAll("-", "/")))),
          Expanded(flex: 2, child: Center(child: Text(moudle.dayOfWeek))),
          Expanded(
              flex: 3,
              child:
                  Center(child: Text(moudle.beginTime?.substring(0, 5) ?? ''))),
          Expanded(flex: 3, child: Center(child: Text("${moudle.hour}h"))),
          Expanded(
              flex: 3,
              child: Center(child: Text(subTypeToString[moudle.subject]!))),
          Expanded(
              flex: 3,
              child:
                  Center(child: Text(courseTypeToString[moudle.courseType]!))),
          Expanded(flex: 3, child: Center(child: Text(moudle.teacher))),
          Expanded(
              flex: 3,
              child: Center(child: Text(gradeToString[moudle.grade]!))),
        ],
      );

      detailDialogContent = FutureBuilder(
          future: moudle.students,
          builder: (BuildContext context,
              AsyncSnapshot<List<StudentModule>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              String stuNames =
                  snapshot.data!.map((e) => e.name).toList().join(",");
              return SizedBox(
                width: 400,
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('日期：${moudle.date}'),
                      Text('星期：${moudle.dayOfWeek}'),
                      Text('时间：${moudle.beginTime?.substring(0, 5) ?? '未填写'}'),
                      Text("小时：${moudle.hour}h"),
                      Text('科目：${subTypeToString[moudle.subject]!}'),
                      Text('课类：${courseTypeToString[moudle.courseType]!}'),
                      Text('老师：${moudle.teacher}'),
                      Text('年级：${gradeToString[moudle.grade]!}'),
                      Row(
                        children: [
                          const Text(
                            '学员：',
                            softWrap: false,
                          ),
                          Text(
                            stuNames,
                            softWrap: true,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          });
    }
    return InkWell(

        /// 点击事件：点击左侧卡片后查询对应数据，提升至父组件刷新后传递至兄弟组件
        onTap: () async {
          showDialog(
              context: context,
              builder: ((context) => Dialog(
                    child: detailDialogContent,
                  )));
        },
        onDoubleTap: widget.listOwner == null
            ? () {}
            : () async {
                StudentModule stu = (widget.listOwner as StudentModule);
                Student_Course student_course = await Global.database
                    .findStudentCourse(
                        stuName: stu.name,
                        registGrade: stu.registGrade,
                        registYear: stu.registYear,
                        courseId: (moudle as CourseMoudle).id);
                // ignore: use_build_context_synchronously
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          child: SizedBox(
                            height: 90,
                            width: 500,
                            child: Row(
                              children: [
                                Text('${student_course.studentName}'),
                                Text(gradeToString[intToGrade[
                                    Global.caculateStudyYear() -
                                        student_course.registYear +
                                        student_course.registGrade]!]!)
                              ],
                            ),
                          ),
                        ));
              },
        child: Container(
            alignment: Alignment.center,
            height: 55,
            margin: const EdgeInsets.fromLTRB(3, 1, 3, 1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Colors.grey[100]!, blurRadius: 10)
                ],
                color: const Color.fromARGB(255, 244, 218, 165)),
            child: card ?? Container()));
  }
}

// 右上角的窗口操作按钮
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

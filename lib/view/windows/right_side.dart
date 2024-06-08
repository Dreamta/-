import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:flutter/material.dart';

class RightSide extends StatelessWidget {
  List<Moudle>? list;
  RightSide({super.key, required this.list});

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
              children: list?.map((e) => _nameCard(e)).toList() ?? [],
            ),
          )),
        ],
      ),
    );
  }
}

// 名称卡片
Widget _nameCard(Moudle moudle) {
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
      // List<Moudle> list = await func() ?? [];
      // onTap(list);
    },
    child: Container(
        height: 55,
        margin: const EdgeInsets.fromLTRB(3, 1, 3, 1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Colors.grey[100]!, blurRadius: 10)],
            color: const Color.fromARGB(255, 244, 218, 165)),
        child: card ?? Container()),
  );
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

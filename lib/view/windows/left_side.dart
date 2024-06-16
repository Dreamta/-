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
  final Function({List<Moudle> moudles}) cardOnTap;
  const LeftSide(
      {super.key, required this.cardOnTap, required this.moudleList});

  @override
  State<StatefulWidget> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  String textfieldContent = '';
  @override
  void initState() {
    super.initState();
    textfieldContent = "在${_getMoudleType(widget.moudleList[0])}搜索";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Container(
          color: Colors.white,
          child:

              ///菜单栏组件
              Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: widget.moudleList.isEmpty
                    ? Container()
                    : SizedBox(
                        height: 40,
                        child: GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.only(bottom: 150),
                              child: Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 2, 30, 0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 500,
                                    child: TextField(
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                          icon: const Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Icon(Icons.search_rounded),
                                          ),
                                          border: InputBorder.none,
                                          hintText:
                                              "在${_getMoudleType(widget.moudleList[0])}中搜索"),
                                      autofocus: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                icon: const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Icon(Icons.search_outlined),
                                ),
                                hintText:
                                    "在${_getMoudleType(widget.moudleList[0])}中搜索",
                                enabled: false),
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.moudleList.length,
                  itemBuilder: (context, index) {
                    return _nameCard(
                        widget.moudleList[index], widget.cardOnTap);
                  },
                ),
              )
            ],
          )),
    );
  }
}

// 名称卡片
Widget _nameCard(Moudle moudle, Function onTap) {
  Widget? card;
  // 用以返回数据列表提交回调函数刷新
  Function func = () {};

  /// 学生卡片构造
  if (moudle is StudentModule) {
    card = Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
      Text(gradeToString[moudle.registGrade]!)
    ]);

    func = () async {
      List<Moudle> list = (await Global.database.findCoursesByStudent(
              moudle.name, moudle.registGrade, moudle.registYear))
          .map((e) => CourseMoudle.fromDatabase(e))
          .toList();
      return list;
    };

    /// 课程卡片构造
  } else if (moudle is TeacherModule) {
    card = Text(
      moudle.name,
      style: const TextStyle(fontSize: 17),
    );
  }
  return InkWell(
    // 点击事件：点击左侧卡片后查询对应数据，提升至父组件刷新后传递至兄弟组件
    onTap: () async {
      List<Moudle> list = await func() ?? [];
      onTap(moudles: list);
    },
    child: Container(
        width: 195,
        height: 55,
        margin: const EdgeInsets.fromLTRB(3, 1, 3, 1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Colors.grey[100]!, blurRadius: 10)],
            color: const Color.fromARGB(255, 244, 218, 165)),
        child: Center(child: card ?? Container())),
  );
}

String _getMoudleType(Moudle moudle) {
  String result = '';
  if (moudle is StudentModule) {
    result = '学生';
  } else if (moudle is CourseMoudle) {
    result = '课程';
  } else if (moudle is TeacherModule) {
    result = '老师';
  }
  return result;
}

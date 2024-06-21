import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bt_system/database/database.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class RightSide extends StatefulWidget {
  List<Moudle>? list;
  Moudle? listOwner;
  RightSide({super.key, required this.list, this.listOwner});
  @override
  State<StatefulWidget> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  late List<CourseType> _courseTypeList;
  late CourseType _curCourseType;
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    _courseTypeList = [
      CourseType.t_1V1,
      CourseType.t_1V2,
      CourseType.t_1V3,
      CourseType.t_1V4,
      CourseType.t_class
    ];
    _curCourseType = _courseTypeList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[100]),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
            child: Row(
              children: [
                Expanded(flex: 4, child: Center(child: Text('日期'))),
                Expanded(flex: 2, child: Center(child: Text('星期'))),
                Expanded(flex: 3, child: Center(child: Text('时间'))),
                Expanded(flex: 3, child: Center(child: Text('小时'))),
                Expanded(flex: 3, child: Center(child: Text('科目'))),
                Expanded(flex: 3, child: Center(child: Text('课类'))),
                Expanded(flex: 3, child: Center(child: Text('老师'))),
                Expanded(flex: 3, child: Center(child: Text('年级'))),
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

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  /// 名称卡片
  Widget _nameCard(BuildContext context, Moudle moudle) {
    Widget? card;
    // Function func = () {};

    if (moudle is StudentModule) {
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
      // func = () async {
      //   List<Moudle> list = (await Global.database.findCoursesByStudent(
      //           moudle.name, moudle.registGrade, moudle.registYear))
      //       .map((e) => CourseMoudle.fromDatabase(e))
      //       .toList();
      //   return list;
      // };

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
    }
    return InkWell(

        /// 点击事件：点击左侧卡片后查询对应数据，提升至父组件刷新后传递至兄弟组件
        onTap: () => _handleTap(moudle),
        onDoubleTap:
            widget.listOwner == null ? null : () => _handleDoubleTap(moudle),
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

  /// 单击返回课程详情
  _handleTap(Moudle moudle) async {
    moudle as CourseMoudle;
    showDialog(
        context: context,
        builder: ((context) => Dialog(
              child: FutureBuilder(
                  future: moudle.students,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<StudentModule>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
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
                              Text(
                                  '时间：${moudle.beginTime?.substring(0, 5) ?? '未填写'}'),
                              Text("小时：${moudle.hour}h"),
                              Text('科目：${subTypeToString[moudle.subject]!}'),
                              Text(
                                  '课类：${courseTypeToString[moudle.courseType]!}'),
                              Text('老师：${moudle.teacher}'),
                              Text('年级：${gradeToString[moudle.grade]!}'),
                              Row(children: [
                                const Text('学员：'),
                                SizedBox(
                                    width: 300,
                                    child: RichText(
                                        text: TextSpan(
                                            text: stuNames,
                                            style: const TextStyle(
                                                color: Colors.black)))),
                              ]),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
            )));
  }

  /// 双击事件返回修改课程报价弹窗
  _handleDoubleTap(Moudle moudle) async {
    // 当前价格
    int? curPrice;
    _curCourseType = (moudle as CourseMoudle).courseType;

    // 根据左侧选择的人物确定右侧课程的关系
    StudentModule stu = (widget.listOwner as StudentModule);
    Student_Course studentCourse;
    studentCourse = await Global.database.findStudentCourse(
        stuName: stu.name,
        registGrade: stu.registGrade,
        registYear: stu.registYear,
        // ignore: unnecessary_cast
        courseId: (moudle as CourseMoudle).id);
    TextEditingController controller = TextEditingController()
      ..text = '${studentCourse.price ?? ''}';

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        curPrice = int.parse(controller.text == '' ? '0' : controller.text);
      }
    });

    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) => Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  height: 50,
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(studentCourse.studentName),
                      Text(gradeToString[intToGrade[Global.caculateStudyYear() -
                          studentCourse.registYear +
                          studentCourse.registGrade]!]!),
                      Text(subTypeToString[moudle.subject]!),
                      SizedBox(
                        width: 60,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: courseTypeToString[_curCourseType]!,
                              onChanged: (value) {
                                setState(() {
                                  _curCourseType = stringToCourseType[value]!;
                                });
                              },
                              items: _courseTypeList
                                  .map<DropdownMenuItem<String>>(
                                      (CourseType value) {
                                return DropdownMenuItem<String>(
                                  value: courseTypeToString[value],
                                  child: Text(courseTypeToString[value]!),
                                );
                              }).toList(),
                              alignment: AlignmentDirectional.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              border: InputBorder.none,
                              hintText: '${studentCourse.price ?? '未报价'}'),
                          onSubmitted: (String value) => curPrice =
                              int.parse(value == '未报价' ? '0' : value),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print(curPrice);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.all(7),
                            child: const Text(
                              '修改报价',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ));
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

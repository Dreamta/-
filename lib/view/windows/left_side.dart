import 'package:bt_system/excel/init_info.dart';
import 'package:bt_system/exception/database_exception.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:bt_system/module/teacher_module.dart';
import 'package:bt_system/view/menu/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';

class LeftSide extends StatefulWidget {
  List<Moudle> moudleList;

  /// 当向右侧传递数据时需要传递是数据拥有者
  final Function({List<Moudle> moudles, required Moudle owner}) cardOnTap;
  LeftSide({super.key, required this.cardOnTap, required this.moudleList});

  @override
  State<StatefulWidget> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  String textfieldContent = '';
  List<Moudle> dataList = [];
  List<Moudle> list = [];
  TextEditingController _controller = TextEditingController();
  int _selectCardIndex = -1;
  @override
  void initState() {
    super.initState();
    textfieldContent =
        "在${widget.moudleList.isEmpty ? '全部' : _getMoudleType(widget.moudleList[0])}搜索";
    dataList = List.from(widget.moudleList);
  }

  @override
  void didUpdateWidget(covariant LeftSide oldWidget) {
    if (list != widget.moudleList) {
      dataList = List.from(widget.moudleList);

      /// 传递引用作为信号机制，
      /// 当触发卡片的ontap事件后会调用父组件的setState函数，
      /// 此时会重新构建 widget，但保留 state，所以会重新调用widget的构造函数并赋值，
      /// 故 widget 数组引用会更新，与list引用不相等，以此作为更新的机制
      list = widget.moudleList;
    }

    super.didUpdateWidget(oldWidget);
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
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => _searchTextField(),
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              icon: const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Icon(Icons.search_outlined),
                              ),
                              hintText:
                                  "在${widget.moudleList.isEmpty ? '全部' : _getMoudleType(widget.moudleList[0])}中搜索",
                              enabled: false),
                        ),
                      ),
                    ),
                    _controller.text == ''
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: SizedBox(
                              width: 30,
                              height: 40,
                              child: GestureDetector(
                                onTap: () {
                                  _controller.text = '';
                                  setState(() {
                                    dataList = widget.moudleList;
                                    _selectCardIndex = -1;
                                  });
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return NameCard(
                      moudle: dataList[index],
                      onTap: (
                          {List<Moudle> moudles = const [],
                          required Moudle owner}) {
                        setState(() {
                          _selectCardIndex = index;
                        });
                        widget.cardOnTap(moudles: moudles, owner: owner);
                      },
                      isSelected: _selectCardIndex == index,
                    );
                    // return _nameCard(
                    //     context, dataList[index], widget.cardOnTap);
                  },
                ),
              )
            ],
          )),
    );
  }

// 搜索框
  Widget _searchTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 150),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 2, 30, 0),
          child: SizedBox(
            height: 50,
            width: 500,
            child: TextField(
              onChanged: (value) {
                _controller.text = value;
                dataList = Global.fuzzySearch(value, widget.moudleList);
                if (value == '') {
                  dataList = widget.moudleList;
                }
                setState(() {});
              },
              decoration: InputDecoration(
                  icon: const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Icon(Icons.search_rounded),
                  ),
                  border: InputBorder.none,
                  hintText:
                      "在${widget.moudleList.isEmpty ? '全部' : _getMoudleType(widget.moudleList[0])}中搜索"),
              autofocus: true,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 销毁控制器以防内存泄露
    _controller.dispose();
    super.dispose();
  }
}

class NameCard extends StatefulWidget {
  final Moudle moudle;
  final Function({List<Moudle> moudles, required Moudle owner}) onTap;
  final bool isSelected;
  const NameCard(
      {super.key,
      required this.moudle,
      required this.onTap,
      required this.isSelected});

  @override
  State<StatefulWidget> createState() {
    return _NameCardState();
  }
}

class _NameCardState extends State<NameCard> {
  Widget? card;

  // 用以返回数据列表提交回调函数刷新
  Function func = () {};
  Color color = const Color.fromARGB(255, 244, 218, 165);

  @override
  Widget build(BuildContext context) {
    func = () {};
    color = widget.isSelected
        ? const Color.fromARGB(255, 234, 192, 108)
        : const Color.fromARGB(255, 244, 218, 165);

    /// 学生卡片构造
    if (widget.moudle is StudentModule) {
      card = Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            (widget.moudle as StudentModule).name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(gradeToString[(widget.moudle as StudentModule).registGrade]!)
      ]);

      func = () async {
        List<Moudle> list = (await Global.database.findCoursesByStudent(
                (widget.moudle as StudentModule).name,
                (widget.moudle as StudentModule).registGrade,
                (widget.moudle as StudentModule).registYear))
            .map((e) => CourseMoudle.fromDatabase(e))
            .toList();
        return list;
      };
    }

    /// 老师卡片构造
    else if (widget.moudle is TeacherModule) {
      card = Text(
        (widget.moudle as TeacherModule).name,
        style: const TextStyle(fontSize: 17),
      );
    }

    return InkWell(
      // 点击事件：点击左侧卡片后查询对应数据，提升至父组件刷新后传递至兄弟组件
      onTap: () async {
        List<Moudle> list = await func() ?? [];

        widget.onTap(moudles: list, owner: widget.moudle);
      },
      child: Container(
          width: 195,
          height: 55,
          margin: const EdgeInsets.fromLTRB(3, 1, 3, 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(color: Colors.grey[100]!, blurRadius: 10)],
              color: color),
          child: Center(child: card ?? Container())),
    );
  }
}

// 名称卡片
Widget _nameCard(BuildContext context, Moudle moudle, Function onTap) {
  Widget? card;
  // 用以返回数据列表提交回调函数刷新
  Function func = () {};
  final Color _initialColor = const Color.fromARGB(255, 244, 218, 165);

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
  }

  /// 老师卡片构造
  else if (moudle is TeacherModule) {
    card = Text(
      moudle.name,
      style: const TextStyle(fontSize: 17),
    );
  }
  Color color = _initialColor;
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return InkWell(
      // 点击事件：点击左侧卡片后查询对应数据，提升至父组件刷新后传递至兄弟组件
      onTap: () async {
        List<Moudle> list = await func() ?? [];
        setState(() {
          color = Colors.blueAccent;
        });
        onTap(moudles: list, owner: moudle);
      },
      child: Container(
          width: 195,
          height: 55,
          margin: const EdgeInsets.fromLTRB(3, 1, 3, 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(color: Colors.grey[100]!, blurRadius: 10)],
              color: color),
          child: Center(child: card ?? Container())),
    );
  });
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

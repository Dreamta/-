import 'package:bt_system/database/database.dart';
import 'package:bt_system/exception/core.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/excel/pick_file.dart';
import 'package:excel/excel.dart';

Future initInfoFromExcel() async {
  Excel? excel = await pickFile();
  Sheet? tableToCorrect = excel?.tables[excel.tables.keys.first];
  MyDatabase database = Global.database;

  /// 目前表从第八行开始有数据
  int i = 8;
  if (tableToCorrect == null) {
    throw ExcelException(message: 'Excel为空');
  } else {
    while (
        // 根据每行信息（一节课的信息)录入
        tableToCorrect.cell(CellIndex.indexByString('A${++i}')).value != null) {
      /// 日期格式 xxxx-xx-xx
      String date = (tableToCorrect.cell(CellIndex.indexByString('A$i')).value
              as SharedString)
          .toString()
          .substring(0, 10);

      /// 星期
      String dayOfWeek = (tableToCorrect
              .cell(CellIndex.indexByString('B$i'))
              .value as SharedString)
          .toString();

      /// 时间
      String beginTime =
          (tableToCorrect.cell(CellIndex.indexByString('C$i')).value == null
                  ? null
                  : tableToCorrect.cell(CellIndex.indexByString('C$i')).value
                      as SharedString)
              .toString();
      // 处理时间误差
      if (beginTime != 'null' && beginTime[7] == '9') {
        beginTime = DateTime.parse("1970-01-01T$beginTime")
            .add(const Duration(seconds: 1))
            .toString()
            .substring(11, 19);
      }

      /// 小时
      double hour =
          (tableToCorrect.cell(CellIndex.indexByString('D$i')).value as num)
              .toDouble();

      /// 识别学科
      // 如果无法识别该行的学科，跳过
      SubjectType? subject = stringToSubType[(tableToCorrect
              .cell(CellIndex.indexByString('E$i'))
              .value as SharedString)
          .toString()];
      if (subject == null) {
        //TODO:干点啥
        continue;
      }

      /// 课程类型
      //TODO: 如果无法识别课程类型需要报错
      CourseType? courseType;
      try {
        courseType = stringToCourseType[(tableToCorrect
                .cell(CellIndex.indexByString('F$i'))
                .value as SharedString)
            .toString()
            .replaceAll('v', 'V')];
        if (courseType == null) {
          throw ExcelException(message: '课程类型非法');
        }
      } on ExcelException catch (e) {
        print(e.message);
        continue;
      }

      /// 老师
      String teacher = (tableToCorrect
              .cell(CellIndex.indexByString('G$i'))
              .value as SharedString)
          .toString();

      /// 年级
      // 如果无法识别该行的年级，跳过
      GRADE? grade = stringToGrade[(tableToCorrect
              .cell(CellIndex.indexByString('H$i'))
              .value as SharedString)
          .toString()];
      if (grade == null) {
        continue;
      }

      /// 提取学生名字用以添加学生表及关系表
      List<String> studentNames = tableToCorrect
          .cell(CellIndex.indexByString('I$i'))
          .value
          .toString()
          .replaceAll('、', ' ')
          .split(' ');
      // CourseMoudle courseMoudle = CourseMoudle.createNewCourse(
      //     date: date,
      //     dayOfWeek: (tableToCorrect.cell(CellIndex.indexByString('B$i')).value
      //             as SharedString)
      //         .toString(),
      //     beginTime:
      //         (tableToCorrect.cell(CellIndex.indexByString('C$i')).value == null
      //                 ? null
      //                 : tableToCorrect
      //                     .cell(CellIndex.indexByString('C$i'))
      //                     .value as SharedString)
      //             .toString(),
      //     hour:
      //         (tableToCorrect.cell(CellIndex.indexByString('D$i')).value as num)
      //             .toDouble(),
      //     subject: subjectType,
      //     courseType: courseType,
      //     teacher: (tableToCorrect.cell(CellIndex.indexByString('G$i')).value
      //             as SharedString)
      //         .toString(),
      //     grade: grade);

      // 使用事务块确保操作原子性
      await Global.database.transaction(() async {
        // 将老师加入数据库
        await Global.database.addTeacher(
            name: (tableToCorrect.cell(CellIndex.indexByString('G$i')).value
                    as SharedString)
                .toString());
        //课程加入数据库
        int courseId = await Global.database.addCourse(
          date: date,
          dayOfWeek: dayOfWeek,
          beginTime: beginTime,
          hour: hour,
          subject: subTypeToString[subject]!,
          courseType: courseTypeToString[courseType]!,
          teacher: teacher,
          grade: grade,
        );

        for (String studentName in studentNames) {
          await database.addStudent(studentName, grade);

          await database.addStudentCourse(
              studentName: studentName,
              registGrade: gradeToInt[grade]!,
              courseId: courseId);
        }
      });
    } // while
  }
}

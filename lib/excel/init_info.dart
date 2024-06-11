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
  // 目前表从第八行开始有数据
  int i = 8;
  // List<CourseMoudle> courses = [];
  if (tableToCorrect == null) {
    //TODO：
    throw ExcelException(message: 'Excel为空');
  } else {
    while (
        // 根据每行信息（一节课的信息录入）
        tableToCorrect.cell(CellIndex.indexByString('A${++i}')).value != null) {
      //读取年级字段
      String? gradeString = ((tableToCorrect
              .cell(CellIndex.indexByString('H$i'))
              .value) as SharedString)
          .toString();
      // 如年级中出现非法字符，跳过该行
      if (stringToGradeIndex[gradeString] == null) {
        continue;
      }

      List<String> studentNames = tableToCorrect
          .cell(CellIndex.indexByString('I$i'))
          .value
          .toString()
          .replaceAll('、', ' ')
          .split(' ');

      // 识别学科
      // 如果无法识别该行的学科，跳过
      SubjectType? subjectType = stringToSubType[(tableToCorrect
              .cell(CellIndex.indexByString('E$i'))
              .value as SharedString)
          .toString()];
      if (subjectType == null) {
        //TODO:干点啥
        continue;
      }
      // 如果无法识别该行的年级，跳过
      GRADE? grade = stringToGrade[(tableToCorrect
              .cell(CellIndex.indexByString('H$i'))
              .value as SharedString)
          .toString()];
      if (grade == null) {
        continue;
      }
      // 识别课程类型
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
      String date = (tableToCorrect.cell(CellIndex.indexByString('A$i')).value
              as SharedString)
          .toString()
          .substring(0, 10);
      CourseMoudle courseMoudle = CourseMoudle.createNewCourse(
          date: date,
          dayOfWeek: (tableToCorrect.cell(CellIndex.indexByString('B$i')).value
                  as SharedString)
              .toString(),
          beginTime:
              (tableToCorrect.cell(CellIndex.indexByString('C$i')).value == null
                      ? null
                      : tableToCorrect.cell(CellIndex.indexByString('C$i')).value
                          as SharedString)
                  .toString(),
          hour: (tableToCorrect.cell(CellIndex.indexByString('D$i')).value as num)
              .toDouble(),
          subject: subjectType,
          courseType: courseType,
          teacher: (tableToCorrect.cell(CellIndex.indexByString('G$i')).value
                  as SharedString)
              .toString(),
          grade: grade,
          studentNames: (tableToCorrect.cell(CellIndex.indexByString('I$i')).value
                  as SharedString)
              .toString()
              .replaceAll('、', ' ')
              .split(' ')
              .toList());

      // 使用事务块确保操作原子性
      await Global.database.transaction(() async {
        // 将老师加入数据库
        await Global.database.addTeacher(
            name: (tableToCorrect.cell(CellIndex.indexByString('G$i')).value
                    as SharedString)
                .toString());
        //课程加入数据库
        int courseId = await Global.database.addCourse(
          date: courseMoudle.date,
          dayOfWeek: courseMoudle.dayOfWeek,
          beginTime: courseMoudle.beginTime ?? '',
          hour: courseMoudle.hour,
          subject: subTypeToString[courseMoudle.subject]!,
          courseType: courseTypeToString[courseMoudle.courseType]!,
          teacher: courseMoudle.teacher,
          grade: courseMoudle.grade,
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

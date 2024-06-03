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
        tableToCorrect.cell(CellIndex.indexByString('A${++i}')).value != null) {
      // 保存获取到的学生姓名
      List<Set<String>> stuStringOfGrades = [
        <String>{},
        <String>{},
        <String>{},
        <String>{},
        <String>{},
        <String>{},
      ];
      {
        //读取年级字段
        String? gradeString = ((tableToCorrect
                .cell(CellIndex.indexByString('H$i'))
                .value) as SharedString)
            .toString();
        // 如年级中出现非法字符，跳过该行
        if (stringToGradeIndex[gradeString] == null) {
          continue;
        }
        // 获取本节课学生信息
        tableToCorrect
            .cell(CellIndex.indexByString('I$i'))
            .value
            .toString()
            .replaceAll('、', ' ')
            .split(' ')
            .forEach((studentName) =>
                stuStringOfGrades[stringToGradeIndex[gradeString]!]
                    .add(studentName));
      }
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

      int courseId = await Global.database.addCourse(
        date: courseMoudle.date,
        dayOfWeek: courseMoudle.dayOfWeek,
        beginTime: courseMoudle.beginTime ?? '',
        hour: courseMoudle.hour,
        subjest: subTypeToString[courseMoudle.subject]!,
        courseType: courseTypeToString[courseMoudle.courseType]!,
        teacher: courseMoudle.teacher,
        grade: courseMoudle.grade,
      );
      //将学生加入数据库
      for (int i = 0; i < 6; i++) {
        //每个年级的学生集合
        for (String studentName in stuStringOfGrades[i]) {
          database.addStudent(studentName, gradeIndexToGrade[i]!);
          database.insertStudentCourse(
              stuName: studentName,
              registGrade: i + 7,
              registYear: DateTime.now().year,
              id: courseId);
        }
      }

      // Global.database.insertStudentCourse(stuName: stu, grade: grade, id: id)
    } // while
  }
}

const Map<String, SubjectType> stringToSubType = {
  '语文': SubjectType.chinese,
  '生物': SubjectType.biology,
  '化学': SubjectType.chemistry,
  '英语': SubjectType.english,
  '地理': SubjectType.geography,
  '历史': SubjectType.history,
  '日本': SubjectType.japanese,
  '数学': SubjectType.math,
  '物理': SubjectType.physics,
  '政治': SubjectType.polity
};

const Map<SubjectType, String> subTypeToString = {
  SubjectType.chinese: '语文',
  SubjectType.biology: '生物',
  SubjectType.chemistry: '化学',
  SubjectType.english: '英语',
  SubjectType.geography: '地理',
  SubjectType.history: '历史',
  SubjectType.japanese: '日本',
  SubjectType.math: '数学',
  SubjectType.physics: '物理',
  SubjectType.polity: '政治'
};

const Map<String, CourseType> stringToCourseType = {
  '1V1': CourseType.t_1V1,
  '1V2': CourseType.t_1V2,
  '1V3': CourseType.t_1V3,
  '1V4': CourseType.t_1V4,
  '班课': CourseType.t_class
};

Map<CourseType, String> courseTypeToString = {
  CourseType.t_1V1: '1V1',
  CourseType.t_1V2: '1V2',
  CourseType.t_1V3: '1V3',
  CourseType.t_1V4: '1V4',
  CourseType.t_class: '班课'
};

const Map<String, int> stringToGradeIndex = {
  '初一': 0,
  '初二': 1,
  '初三': 2,
  '高一': 3,
  '高二': 4,
  '高三': 5,
};

const Map<int, GRADE> gradeIndexToGrade = {
  0: GRADE.grade7,
  1: GRADE.grade8,
  2: GRADE.grade9,
  3: GRADE.grade10,
  4: GRADE.grade11,
  5: GRADE.grade12,
};

const Map<String, GRADE> stringToGrade = {
  '初一': GRADE.grade7,
  '初二': GRADE.grade8,
  '初三': GRADE.grade9,
  '高一': GRADE.grade10,
  '高二': GRADE.grade11,
  '高三': GRADE.grade12,
};

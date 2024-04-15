import 'package:bt_system/cache.dart';
import 'package:bt_system/database/database.dart';
import 'package:bt_system/exception/core.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:bt_system/excel/pick_file.dart';
import 'package:excel/excel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future initInfoFromExcel() async {
  Excel? excel = await pickFile();
  Sheet? tableToCorrect = excel?.tables[excel.tables.keys.first];

  // 目前表从第八行开始有数据
  int i = 8;
  if (tableToCorrect == null) {
    //TODO：
    // throw ExcelException(message: 'Excel为空');
  } else {
    List<CourseMoudle> courses = [];
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
    }
  }
}

_initStuInfo(Sheet table) {
  MyDatabase database = Global.database;
  int i = 8;
  // 按照
  List<Set<String>> stuStringOfGrades = [
    <String>{},
    <String>{},
    <String>{},
    <String>{},
    <String>{},
    <String>{},
  ];
  //遍历各行，如该行不为空（第一列日期有值），说明有数据，读取学生信息
  while (table.cell(CellIndex.indexByString('A${++i}')).value != null) {
    //读取年级字段
    String? gradeString =
        ((table.cell(CellIndex.indexByString('H$i')).value) as SharedString)
            .toString();
    // 如年级中出现非法字符，跳过该行
    if (stringToGradeIndex[gradeString] == null) {
      continue;
    }

    table
        .cell(CellIndex.indexByString('I$i'))
        .value
        .toString()
        .replaceAll('、', ' ')
        .split(' ')
        .forEach((studentName) =>
            stuStringOfGrades[stringToGradeIndex[gradeString]!]
                .add(studentName));
  }

  //将学生加入数据库
  for (int i = 0; i < 6; i++) {
    //每个年级的学生集合
    for (String studentName in stuStringOfGrades[i]) {
      database.insertStudent(studentName, gradeIndexToGrade[i]!);
    }
  }
}

_initCourseInfo(Sheet table, List<CourseMoudle> courses) {
  int i = 8;
  //找到第一个非空行
  // while (table.cell(CellIndex.indexByString('A${i}')).value == null) {
  //   i++;
  // }
  //遍历各行，如该行不为空（第一列日期有值），说明有课程数据
  while (table.cell(CellIndex.indexByString('A${++i}')).value != null) {
    // try {} catch (e) {}
    // 如果无法识别该行的学科，跳过
    SubjectType? subjectType = stringToSubType[
        (table.cell(CellIndex.indexByString('E$i')).value as SharedString)
            .toString()];
    if (subjectType == null) {
      //TODO:干点啥
      continue;
    }
    // 如果无法识别该行的年级，跳过
    GRADE? grade = stringToGrade[
        (table.cell(CellIndex.indexByString('H$i')).value as SharedString)
            .toString()];
    if (grade == null) {
      continue;
    }
    //TODO: 如果无法识别课程类型需要报错
    CourseType? courseType;
    try {
      courseType = stringToCourseType[
          (table.cell(CellIndex.indexByString('F$i')).value as SharedString)
              .toString()
              .replaceAll('v', 'V')];
      if (courseType == null) {
        throw ExcelException(message: '课程类型非法');
      }
    } on ExcelException catch (e) {
      print(e.message);
      continue;
    }

    String date =
        (table.cell(CellIndex.indexByString('A$i')).value as SharedString)
            .toString()
            .substring(0, 10);

    courses.add(CourseMoudle.createNewCourse(
        date: date,
        dayOfWeek:
            (table.cell(CellIndex.indexByString('B$i')).value as SharedString)
                .toString(),
        beginTime: (table.cell(CellIndex.indexByString('C$i')).value == null
                ? null
                : table.cell(CellIndex.indexByString('C$i')).value
                    as SharedString)
            .toString(),
        hour: (table.cell(CellIndex.indexByString('D$i')).value as num)
            .toDouble(),
        subject: subjectType,
        courseType: courseType,
        teacher:
            (table.cell(CellIndex.indexByString('G$i')).value as SharedString)
                .toString(),
        grade: grade,
        studentNames:
            (table.cell(CellIndex.indexByString('I$i')).value as SharedString)
                .toString()
                .replaceAll('、', ' ')
                .split(' ')
                .toList()));
  }
  for (CourseMoudle courseMoudle in courses) {
    Global.database.insertCourse(
        date: courseMoudle.date,
        dayOfWeek: courseMoudle.dayOfWeek,
        beginTime: courseMoudle.beginTime ?? '',
        hour: courseMoudle.hour,
        subjest: subTypeToString[courseMoudle.subject]!,
        courseType: courseTypeToString[courseMoudle.courseType]!,
        teacher: courseMoudle.teacher,
        grade: courseMoudle.grade);
  }
}

_initTeacherInfo(Sheet table) {}

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

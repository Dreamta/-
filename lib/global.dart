import 'package:bt_system/cache.dart';
import 'package:bt_system/database/database.dart';

class Global {
  static late final MyDatabase database;
  // static late final Cache cache;
  static Future initialize() async {
    database = MyDatabase();
    // 触发数据库初始化
    try {
      await database.customSelect('SELECT 1;').getSingle();
    } catch (e) {
      // 忽略异常，因为这只是为了触发初始化
      print(e);
    }

    await Cache.preInit();
    // database.
  }

  static int caculateStudyYear() {
    // 如果是九月以后则学年加 1
    return DateTime.now().year + DateTime.now().month > 8 ? 1 : 0;
  }
}

/// 常量定义
// ignore: constant_identifier_names
const DATABASE_HAS_INIT = 'dataBaseHasInit';

// ignore: constant_identifier_names
enum GRADE { grade7, grade8, grade9, grade10, grade11, grade12 }

// 课程类型
// ignore: constant_identifier_names
enum CourseType { t_1V1, t_1V2, t_1V3, t_1V4, t_class }

// 语数外史地政生化物，日语
// 学科类型
enum SubjectType {
  math,
  chinese,
  english,
  history,
  geography,
  polity,
  biology,
  chemistry,
  physics,
  japanese
}

const Map<GRADE, int> gradeToInt = {
  GRADE.grade7: 7,
  GRADE.grade8: 8,
  GRADE.grade9: 9,
  GRADE.grade10: 10,
  GRADE.grade11: 11,
  GRADE.grade12: 12
};

const Map<int, GRADE> intToGrade = {
  7: GRADE.grade7,
  8: GRADE.grade8,
  9: GRADE.grade9,
  10: GRADE.grade10,
  11: GRADE.grade11,
  12: GRADE.grade12
};

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

const Map<String, GRADE> stringToGrade = {
  '初一': GRADE.grade7,
  '初二': GRADE.grade8,
  '初三': GRADE.grade9,
  '高一': GRADE.grade10,
  '高二': GRADE.grade11,
  '高三': GRADE.grade12,
};

const Map<GRADE, String> gradeToString = {
  GRADE.grade7: '初一',
  GRADE.grade8: '初二',
  GRADE.grade9: '初三',
  GRADE.grade10: '高一',
  GRADE.grade11: '高二',
  GRADE.grade12: '高三'
};

//TODO: 年级要按年份自动增长

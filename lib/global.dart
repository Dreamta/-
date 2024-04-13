// import 'package:bt_system/cache.dart';
import 'package:bt_system/database/database.dart';

class Global {
  static late final MyDatabase database;
  // static late final Cache cache;
  static Future initialize() async {
    database = MyDatabase();
    // 触发数据库初始化
    try {
      await database.customSelect('SELECT 1;').getSingle();
    } catch (_) {
      // 忽略异常，因为这只是为了触发初始化
    }

    // await Cache.preInit();
    // database.
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


// //TODO: 年级要按年份自动增长
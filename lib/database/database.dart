import 'dart:ffi';

import 'package:bt_system/exception/database_exception.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:drift/native.dart';

part 'database.g.dart';

// 学生表 需要定时更新学生年级
@DataClassName('Student')
class Students extends Table {
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get grade => integer().customConstraint('NOT NULL')();
  @override
  Set<Column> get primaryKey => {name, grade};
}

// 课程表
@DataClassName('Course')
class Courses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text().withLength(min: 10, max: 10)();
  TextColumn get dayOfWeek => text().withLength(min: 1, max: 3)();
  TextColumn get beginTime => text().withLength(min: 1, max: 50).nullable()();
  RealColumn get hour => real().nullable()();
  TextColumn get subject => text().withLength(min: 1, max: 50)();
  TextColumn get courseType => text().withLength(min: 1, max: 50)();
  TextColumn get teacher => text().withLength(min: 1, max: 50)();
  IntColumn get grade => integer().customConstraint('NOT NULL')();
  IntColumn get compensation => integer()();
  // TextColumn get studentsNames => text().withLength(min: 1, max: 8)();
}

// 老师表
@DataClassName('Teacher')
class Teachers extends Table {
  TextColumn get name => text().withLength(min: 1, max: 50)();

  @override
  Set<Column> get primaryKey => {name};
}

// 学生-课程表
@DataClassName('Student_Course')
class StudentCourses extends Table {
  TextColumn get studentName => text().withLength(min: 1, max: 50)();
  IntColumn get grade => integer().customConstraint('NOT NULL')();
  IntColumn get courseId => integer().customConstraint('NOT NULL')();
  IntColumn get price => integer().customConstraint('NOT NULL')();
  @override
  Set<Column> get primaryKey => {studentName, grade, courseId};
}

// 老师学生表
@DataClassName('Student_Teacher')
class StudentTeacher extends Table {
  TextColumn get studentName => text().withLength(min: 1, max: 50)();
  IntColumn get grade => integer().customConstraint('NOTNULL')();
  TextColumn get teacherName => text().withLength(min: 1, max: 50)();
  @override
  Set<Column> get primaryKey => {studentName, grade, teacherName};
}

@DriftDatabase(tables: [Students, Courses, StudentCourses])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// 查找所有学生,若没找到数据会返回一个空列表
  Future<List<StudentModule>> getAllStudents() async {
    List<dynamic> studentList;

    try {
      studentList = await select(students).get();
      //当没有找到任何数据，get会返回一个空列表
      // if (students.isEmpty) {}
      List<StudentModule> studentMoudles = studentList
          .map((student) => StudentModule.fromDatabase(student))
          .toList();
      return studentMoudles;
    } catch (e) {
      throw TableNotExistException();
    }
  }

  /// 查找所有课程
  Future<List<CourseMoudle>> getAllCourses() async {
    List<dynamic> courseList;

    try {
      courseList = await select(courses).get();
      //当没有找到任何数据，get会返回一个空列表
      // if (students.isEmpty) {}
      List<CourseMoudle> courseMoudles = courseList
          .map((course) => CourseMoudle.fromDatabase(course))
          .toList();
      return courseMoudles;
    } catch (e) {
      throw TableNotExistException();
    }
  }

  // 删除所有课程
  Future deleteAllCourses() async {
    await delete(courses).go();
  }

  // 基于姓名和年级查找学生
  Future<StudentModule?> getStudentByNameAndGrade(
      String name, GRADE grade) async {
    Student? student = await (select(students)
          ..where((tbl) => (tbl.name.equals(name) &
              tbl.grade.equals(gradeToInt[grade] ?? 0))))
        .getSingleOrNull();
    return student == null ? null : StudentModule.fromDatabase(student);
  }

  /// 删除学生
  Future deleteAllStudent() async {
    await delete(students).go();
  }

  /// 添加学生
  Future<void> insertStudent(String name, GRADE grade) async {
    // 首先检查学生是否已存在
    final existingStudent = await (select(students)
          ..where((tbl) =>
              tbl.name.equals(name) & tbl.grade.equals(gradeToInt[grade] ?? 0)))
        .getSingleOrNull();

    if (existingStudent == null) {
      // 学生不存在，插入新学生
      final student = StudentsCompanion(
        name: Value(name),
        grade: Value(gradeToInt[grade] ?? 0),
      );
      await into(students).insert(student);
    } else {
      // 学生已存在，处理相应逻辑（例如返回错误消息）
      // ...
    }
  }

  /// 添加课程
  Future<void> insertCourse(
      {required String date,
      required String dayOfWeek,
      required String beginTime,
      required double hour,
      required String subjest,
      required String courseType,
      required String teacher,
      required GRADE grade}) async {
    final CoursesCompanion course = CoursesCompanion(
      date: Value(date),
      dayOfWeek: Value(dayOfWeek),
      beginTime: Value(beginTime),
      hour: Value(hour),
      subject: Value(subjest),
      courseType: Value(courseType),
      teacher: Value(teacher),
      grade: Value(gradeToInt[grade] ?? 0),
    );

    await into(courses).insert(course);
  }
}

/// 链接数据库
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    print(dbFolder.path);
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

Map<GRADE, int> gradeToInt = {
  GRADE.grade7: 7,
  GRADE.grade8: 8,
  GRADE.grade9: 9,
  GRADE.grade10: 10,
  GRADE.grade11: 11,
  GRADE.grade12: 12
};

Map<int, GRADE> intToGrade = {
  7: GRADE.grade7,
  8: GRADE.grade8,
  9: GRADE.grade9,
  10: GRADE.grade10,
  11: GRADE.grade11,
  12: GRADE.grade12
};

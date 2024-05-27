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

// 学生表 (存入时年级和存入年份固定，计算当前年级使用 注册年级+当前年份-注册年份)
@DataClassName('Student')
class Students extends Table {
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get registGrade => integer().customConstraint('NOT NULL')();
  IntColumn get registYear => integer().customConstraint('NOT NULL')();
  @override
  Set<Column> get primaryKey => {name, registGrade, registYear};
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
  IntColumn get compensation => integer().nullable()();
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
  IntColumn get registGrade => integer().customConstraint('NOT NULL')();
  IntColumn get registYear => integer().customConstraint('NOT NULL')();
  IntColumn get courseId => integer().customConstraint('NOT NULL')();
  IntColumn get price => integer().nullable()();
  @override
  Set<Column> get primaryKey =>
      {studentName, registGrade, registYear, courseId};
}

// 老师学生表
@DataClassName('Student_Teacher')
class StudentTeacher extends Table {
  TextColumn get studentName => text().withLength(min: 1, max: 50)();
  IntColumn get registGrade => integer().customConstraint('NOT NULL')();
  IntColumn get registYear => integer().customConstraint('NOT NULL')();
  TextColumn get teacherName => text().withLength(min: 1, max: 50)();
  @override
  Set<Column> get primaryKey =>
      {studentName, registGrade, registYear, teacherName};
}

@DriftDatabase(
    tables: [Students, Courses, StudentCourses, Teachers, StudentTeacher])
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

  /// 添加课程
  Future<int> insertCourse(
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

    return await into(courses).insert(course);
  }

  // 删除所有学生课程关系
  Future deleteAllStudentCourses() async {
    await delete(studentCourses).go();
  }

  // 添加老师
  Future<void> insertTeacher(String name) async {
    final existTeacher = await (select(teachers)
          ..where((tbl) => tbl.name.equals(name)))
        .getSingleOrNull();
    if (existTeacher == null) {
      final TeachersCompanion teacher = TeachersCompanion(name: Value(name));
      await into(teachers).insert(teacher);
    } else {
      // 抛出错误信息
    }
  }

  // 删除所有老师
  Future deleteAllTeachers() async {
    await delete(teachers).go();
  }

  // 基于姓名和当前年级查找学生
  Future<StudentModule?> getStudentByNameAndGrade(
      String name, GRADE curGrade, int curYear) async {
    // int expectGrade = (gradeToInt[curGrade] ?? 0) - tbl.registGrade + curYear;
    Student? student = await (select(students)
          ..where((tbl) => (tbl.name.equals(name) &
              // 注册年级 = 当前年级 - 注册年份 + 当前年份

              tbl.registGrade.equals((gradeToInt[curGrade] ?? 0) -
                  (tbl.registGrade as int) +
                  curYear))))
        .getSingleOrNull();
    return student == null ? null : StudentModule.fromDatabase(student);
  }

  /// 删除学生
  Future deleteAllStudent() async {
    await delete(students).go();
  }

  /// 添加学生
  Future<void> insertStudent(String name, GRADE grade, int year) async {
    // 首先检查学生是否已存在
    final existingStudent = await (select(students)
          ..where((tbl) =>
              tbl.name.equals(name) &
              tbl.registGrade.equals(gradeToInt[grade] ?? 0) &
              tbl.registYear.equals(year)))
        .getSingleOrNull();

    if (existingStudent == null) {
      // 学生不存在，插入新学生
      final student = StudentsCompanion(
          name: Value(name),
          registGrade: Value(gradeToInt[grade] ?? 0),
          registYear: Value(year));
      await into(students).insert(student);
    } else {
      // 学生已存在，处理相应逻辑（例如返回错误消息）
      // ...
    }
  }

  // 添加学生课程关系(添加课程时必需同步执行，没有没有学生的课)
  Future insertStudentCourse(
      {required String stuName,
      required int registGrade,
      required int registYear,
      required int id,
      int? price}) async {
    final StudentCoursesCompanion companion = StudentCoursesCompanion(
        studentName: Value(stuName),
        registGrade: Value(registGrade),
        registYear: Value(registYear),
        courseId: Value(id),
        price: Value(price ?? -1));

    return await into(studentCourses).insert(companion);
  }

  // 添加老师学生关系
  Future insertStudentTeacher(
      {required String stuName,
      required GRADE registGrade,
      required int registYear,
      required String teacherName}) async {
    StudentTeacherCompanion studentTeacherCompanion = StudentTeacherCompanion(
        studentName: Value(stuName),
        registGrade: Value(gradeToInt[registGrade] ?? 0),
        registYear: Value(registYear));
    return await into(studentTeacher).insert(studentTeacherCompanion);
  }

  // 删除老师学生关系
  Future deleteStudentTeacher() async {
    await delete(studentTeacher).go();
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

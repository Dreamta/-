import 'dart:ffi';

import 'package:bt_system/exception/database_exception.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:bt_system/module/teacher_module.dart';
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

// 删除

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

  /// 查找所有老师
  Future<List<TeacherModule>> getAllTeacher() async {
    List<dynamic> teacherData;

    try {
      teacherData = await select(teachers).get();
      return teacherData.map((e) => TeacherModule.fromDatabase(e)).toList();
    } catch (e) {
      throw DataNotFoundException();
    }
  }

  /// 删除所有课程
  Future deleteAllCourses() async {
    await delete(studentCourses).go();
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

  /// 删除所有学生课程关系
  /// 单独暴露
  Future deleteAllStudentCourses() async {
    await delete(studentCourses).go();
  }

  /// 添加老师
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

  /// 删除所有老师
  Future deleteAllTeachers() async {
    // 因为课程和老师是一一对应关系，所以删除老师时要把对应课程删除
    await delete(courses).go();
    // 同理删除老师学生关系
    await delete(studentTeacher).go();
    await delete(teachers).go();
  }

  /// 基于姓名和当前年级查找学生
  Future<Student> getStudentByNameAndGrade(String name, GRADE curGrade) async {
    // int expectGrade = (gradeToInt[curGrade] ?? 0) - tbl.registGrade + curYear;

    Student? student = await (select(students)
          ..where((tbl) => (tbl.name.equals(name) &
              // 注册年级 = 当前年级 - 注册年份 + 当前年份

              tbl.registGrade.equals((gradeToInt[curGrade] ?? 0) -
                  (tbl.registYear as int) +
                  Global.caculateStudyYear()))))
        .getSingleOrNull();
    if (student == null) {
      throw Error();
    }
    return student;
  }

  /// 删除所有学生
  Future deleteAllStudent() async {
    // 删除对应的老师学生关系
    await delete(studentTeacher).go();
    await delete(studentCourses).go();
    await delete(students).go();
  }

  // 删除指定学生
  Future deleteStudent({required String name, required GRADE curGrade}) async {
    await (delete(students)
          ..where((tbl) => (tbl.name.equals(name) &
              // 注册年级 = 当前年级 - 注册年份 + 当前年份

              tbl.registGrade.equals((gradeToInt[curGrade] ?? 0) -
                  (tbl.registYear as int) +
                  Global.caculateStudyYear()))))
        .go();
  }

  /// 添加学生
  Future<void> insertStudent(String name, GRADE curGrade) async {
    // 首先检查学生是否已存在
    final existingStudent = await (select(students)
          ..where((tbl) =>
              tbl.name.equals(name) &
              // 检测注册年级 = 注册年级 + 注册学年 - 当前学年
              tbl.registGrade.equals(gradeToInt[curGrade] ??
                  0 - (tbl.registYear as int) + Global.caculateStudyYear())))
        .getSingleOrNull();

    if (existingStudent == null) {
      // 学生不存在，插入新学生
      final student = StudentsCompanion(
          name: Value(name),
          registGrade: Value(gradeToInt[curGrade] ?? 0),
          registYear: Value(Global.caculateStudyYear()));
      await into(students).insert(student);
    } else {
      // 学生已存在，处理相应逻辑（例如返回错误消息）
      // ...
    }
  }

  /// 添加学生课程关系(添加课程时必需同步执行，没有没有学生的课),
  /// 需要允许对外暴露这个函数，因为需要为一个课程单独添加学生
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

  /// 添加老师学生关系
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

  // 查找老师学生关系
  Future _getStudentTeacher(Moudle moudle) async {
    List<Student_Teacher> stuTeacherList = await (select(studentTeacher)
          ..where(
              (tbl) => tbl.studentName.equals((moudle as StudentModule).name)))
        .get();
    // 根据学生查找关系表
    if (moudle is StudentModule) {
    } else if (moudle is TeacherModule) {}
  }

  // 根据学生或老师删除对应关系
  Future _deleteStuTeacherByStuOrTeacher(Moudle moudle) async {
    // 根据学生查找关系表
    if (moudle is StudentModule) {
      await (delete(studentTeacher)
            ..where((tbl) =>
                tbl.studentName.equals(moudle.name) &
                tbl.registGrade.equals((gradeToInt[moudle.grade] ?? 0) -
                    (tbl.registGrade as int) +
                    Global.caculateStudyYear())))
          .go();
    } else if (moudle is TeacherModule) {
      await (delete(studentTeacher)
            ..where((tbl) => tbl.teacherName.equals(moudle.name)))
          .go();
    }
  }

  // 删除所有老师学生关系
  Future _deleteStudentTeacher() async {
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

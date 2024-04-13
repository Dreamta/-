import 'package:bt_system/database/database.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/class_module.dart';

class StudentModule {
  // late int id;
  // 根据年级和姓名唯一确认一个学生
  String name;
  GRADE grade;
  final Set<CourseMoudle> _courses = <CourseMoudle>{};

  StudentModule.createNewStudent({required this.name, required this.grade});

  // 将 Drift 的 Student 对象转换为 StudentModule 对象
  StudentModule.fromDatabase(Student student)
      : name = student.name,
        grade = intToGrade[student.grade]!;

  // // 将 StudentModule 对象转换为 Drift 的 StudentsCompanion，用于数据库操作
  // StudentsCompanion convertModuleToStudent(StudentModule module) {
  //   return StudentsCompanion(
  //       name: Value(name), grade: Value());
  // }

  StudentModule addCourse(CourseMoudle course) {
    _courses.add(course);
    return this;
  }

  Set<CourseMoudle> getCourses() {
    return _courses;
  }
}

// const Map<String, GRADE> stringToGrade = {
//   '初一': GRADE.grade7,
//   '初二': GRADE.grade8,
//   '初三': GRADE.grade9,
//   '高一': GRADE.grade10,
//   '高二': GRADE.grade11,
//   '高三': GRADE.grade12,
// };

// const Map<GRADE, String> gradeToString = {
//   GRADE.grade7: '初一',
//   GRADE.grade8: '初二',
//   GRADE.grade9: '初三',
//   GRADE.grade10: '高一',
//   GRADE.grade11: '高二',
//   GRADE.grade12: '高三',
// };

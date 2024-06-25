import 'package:bt_system/database/database.dart';
import 'package:bt_system/global.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';
import 'package:lpinyin/lpinyin.dart';

class CourseMoudle extends Moudle {
  int id;
  String date;
  String dayOfWeek;
  String? beginTime;
  double hour;
  SubjectType subject;
  CourseType courseType;
  String teacher;
  GRADE grade; //初一到高一是7-12

  Future<List<StudentModule>> get students async {
    List<Student> students = await Global.database.findStudentsByCourse(id);
    return students.map((e) => StudentModule.fromDatabase(e)).toList();
  }

  CourseMoudle.createNewCourse(
      {required this.id,
      required this.date,
      required this.dayOfWeek,
      required this.beginTime,
      required this.hour,
      required this.subject,
      // 课程类型
      required this.courseType,
      required this.teacher,
      required this.grade});

  CourseMoudle.fromDatabase(Course course)
      : id = course.id,
        date = course.date,
        dayOfWeek = course.dayOfWeek,
        beginTime = course.beginTime == 'null' ? null : course.beginTime,
        hour = course.hour as double,
        subject = stringToSubType[course.subject]!,
        courseType = stringToCourseType[course.courseType]!,
        teacher = course.teacher,
        grade = intToGrade[course.grade]!;

  @override
  String toString() {
    return (date +
            (beginTime ?? '') +
            hour.toString() +
            PinyinHelper.getPinyin(dayOfWeek +
                subTypeToString[subject]! +
                courseTypeToString[courseType]! +
                teacher +
                gradeToString[grade]!))
        .replaceAll(' ', '');
  }
}

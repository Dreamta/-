import 'package:bt_system/database/database.dart';
import 'package:bt_system/excel/init_info.dart';
// import 'package:bt_system/excel/init_info.dart';
import 'package:bt_system/global.dart';

class CourseMoudle {
  String date;
  String dayOfWeek;
  String? beginTime;
  double hour;
  SubjectType subject;
  CourseType courseType;
  String teacher;
  GRADE grade; //初一到高一是7-12
  late List<String> studentNames;

  CourseMoudle.createNewCourse(
      {required this.date,
      required this.dayOfWeek,
      required this.beginTime,
      required this.hour,
      required this.subject,
      // 课程类型
      required this.courseType,
      required this.teacher,
      required this.grade,
      required this.studentNames});

  CourseMoudle.fromDatabase(Course course)
      : date = course.date,
        dayOfWeek = course.dayOfWeek,
        beginTime = course.beginTime,
        hour = course.hour as double,
        subject = stringToSubType[course.subject]!,
        courseType = stringToCourseType[course.courseType]!,
        teacher = course.teacher,
        grade = gradeIndexToGrade[course.grade - 7]!;
}

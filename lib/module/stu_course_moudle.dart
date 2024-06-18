import 'package:bt_system/database/database.dart';
import 'package:bt_system/module/class_module.dart';
import 'package:bt_system/module/module_template.dart';
import 'package:bt_system/module/stu_module.dart';

class StuCourseMoudle extends Moudle {
  StudentModule student;
  CourseMoudle course;
  int price;
  StuCourseMoudle.fromDataBase(
      Student_Course studentCourse, this.student, this.course)
      : price = studentCourse.price ?? 0;
}

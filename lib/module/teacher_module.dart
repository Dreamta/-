import 'package:bt_system/database/database.dart';
import 'package:bt_system/module/module_template.dart';

class TeacherModule extends Moudle {
  String name;
  TeacherModule.createNewTeacher({required this.name});

  TeacherModule.fromDatabase(Teacher teacher) : name = teacher.name;
}

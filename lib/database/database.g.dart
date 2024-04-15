// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<int> grade = GeneratedColumn<int>(
      'grade', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [name, grade];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(Insertable<Student> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name, grade};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grade'])!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final String name;
  final int grade;
  const Student({required this.name, required this.grade});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['grade'] = Variable<int>(grade);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      name: Value(name),
      grade: Value(grade),
    );
  }

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      name: serializer.fromJson<String>(json['name']),
      grade: serializer.fromJson<int>(json['grade']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'grade': serializer.toJson<int>(grade),
    };
  }

  Student copyWith({String? name, int? grade}) => Student(
        name: name ?? this.name,
        grade: grade ?? this.grade,
      );
  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('name: $name, ')
          ..write('grade: $grade')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, grade);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.name == this.name &&
          other.grade == this.grade);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<String> name;
  final Value<int> grade;
  final Value<int> rowid;
  const StudentsCompanion({
    this.name = const Value.absent(),
    this.grade = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentsCompanion.insert({
    required String name,
    required int grade,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        grade = Value(grade);
  static Insertable<Student> custom({
    Expression<String>? name,
    Expression<int>? grade,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (grade != null) 'grade': grade,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentsCompanion copyWith(
      {Value<String>? name, Value<int>? grade, Value<int>? rowid}) {
    return StudentsCompanion(
      name: name ?? this.name,
      grade: grade ?? this.grade,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (grade.present) {
      map['grade'] = Variable<int>(grade.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('name: $name, ')
          ..write('grade: $grade, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoursesTable extends Courses with TableInfo<$CoursesTable, Course> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 10, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dayOfWeekMeta =
      const VerificationMeta('dayOfWeek');
  @override
  late final GeneratedColumn<String> dayOfWeek = GeneratedColumn<String>(
      'day_of_week', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _beginTimeMeta =
      const VerificationMeta('beginTime');
  @override
  late final GeneratedColumn<String> beginTime = GeneratedColumn<String>(
      'begin_time', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<double> hour = GeneratedColumn<double>(
      'hour', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _subjectMeta =
      const VerificationMeta('subject');
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
      'subject', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _courseTypeMeta =
      const VerificationMeta('courseType');
  @override
  late final GeneratedColumn<String> courseType = GeneratedColumn<String>(
      'course_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _teacherMeta =
      const VerificationMeta('teacher');
  @override
  late final GeneratedColumn<String> teacher = GeneratedColumn<String>(
      'teacher', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<int> grade = GeneratedColumn<int>(
      'grade', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _compensationMeta =
      const VerificationMeta('compensation');
  @override
  late final GeneratedColumn<int> compensation = GeneratedColumn<int>(
      'compensation', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        dayOfWeek,
        beginTime,
        hour,
        subject,
        courseType,
        teacher,
        grade,
        compensation
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(Insertable<Course> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
          _dayOfWeekMeta,
          dayOfWeek.isAcceptableOrUnknown(
              data['day_of_week']!, _dayOfWeekMeta));
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('begin_time')) {
      context.handle(_beginTimeMeta,
          beginTime.isAcceptableOrUnknown(data['begin_time']!, _beginTimeMeta));
    }
    if (data.containsKey('hour')) {
      context.handle(
          _hourMeta, hour.isAcceptableOrUnknown(data['hour']!, _hourMeta));
    }
    if (data.containsKey('subject')) {
      context.handle(_subjectMeta,
          subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('course_type')) {
      context.handle(
          _courseTypeMeta,
          courseType.isAcceptableOrUnknown(
              data['course_type']!, _courseTypeMeta));
    } else if (isInserting) {
      context.missing(_courseTypeMeta);
    }
    if (data.containsKey('teacher')) {
      context.handle(_teacherMeta,
          teacher.isAcceptableOrUnknown(data['teacher']!, _teacherMeta));
    } else if (isInserting) {
      context.missing(_teacherMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('compensation')) {
      context.handle(
          _compensationMeta,
          compensation.isAcceptableOrUnknown(
              data['compensation']!, _compensationMeta));
    } else if (isInserting) {
      context.missing(_compensationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Course(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      dayOfWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day_of_week'])!,
      beginTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}begin_time']),
      hour: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hour']),
      subject: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject'])!,
      courseType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}course_type'])!,
      teacher: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}teacher'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grade'])!,
      compensation: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}compensation'])!,
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class Course extends DataClass implements Insertable<Course> {
  final int id;
  final String date;
  final String dayOfWeek;
  final String? beginTime;
  final double? hour;
  final String subject;
  final String courseType;
  final String teacher;
  final int grade;
  final int compensation;
  const Course(
      {required this.id,
      required this.date,
      required this.dayOfWeek,
      this.beginTime,
      this.hour,
      required this.subject,
      required this.courseType,
      required this.teacher,
      required this.grade,
      required this.compensation});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['day_of_week'] = Variable<String>(dayOfWeek);
    if (!nullToAbsent || beginTime != null) {
      map['begin_time'] = Variable<String>(beginTime);
    }
    if (!nullToAbsent || hour != null) {
      map['hour'] = Variable<double>(hour);
    }
    map['subject'] = Variable<String>(subject);
    map['course_type'] = Variable<String>(courseType);
    map['teacher'] = Variable<String>(teacher);
    map['grade'] = Variable<int>(grade);
    map['compensation'] = Variable<int>(compensation);
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      date: Value(date),
      dayOfWeek: Value(dayOfWeek),
      beginTime: beginTime == null && nullToAbsent
          ? const Value.absent()
          : Value(beginTime),
      hour: hour == null && nullToAbsent ? const Value.absent() : Value(hour),
      subject: Value(subject),
      courseType: Value(courseType),
      teacher: Value(teacher),
      grade: Value(grade),
      compensation: Value(compensation),
    );
  }

  factory Course.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Course(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      dayOfWeek: serializer.fromJson<String>(json['dayOfWeek']),
      beginTime: serializer.fromJson<String?>(json['beginTime']),
      hour: serializer.fromJson<double?>(json['hour']),
      subject: serializer.fromJson<String>(json['subject']),
      courseType: serializer.fromJson<String>(json['courseType']),
      teacher: serializer.fromJson<String>(json['teacher']),
      grade: serializer.fromJson<int>(json['grade']),
      compensation: serializer.fromJson<int>(json['compensation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'dayOfWeek': serializer.toJson<String>(dayOfWeek),
      'beginTime': serializer.toJson<String?>(beginTime),
      'hour': serializer.toJson<double?>(hour),
      'subject': serializer.toJson<String>(subject),
      'courseType': serializer.toJson<String>(courseType),
      'teacher': serializer.toJson<String>(teacher),
      'grade': serializer.toJson<int>(grade),
      'compensation': serializer.toJson<int>(compensation),
    };
  }

  Course copyWith(
          {int? id,
          String? date,
          String? dayOfWeek,
          Value<String?> beginTime = const Value.absent(),
          Value<double?> hour = const Value.absent(),
          String? subject,
          String? courseType,
          String? teacher,
          int? grade,
          int? compensation}) =>
      Course(
        id: id ?? this.id,
        date: date ?? this.date,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        beginTime: beginTime.present ? beginTime.value : this.beginTime,
        hour: hour.present ? hour.value : this.hour,
        subject: subject ?? this.subject,
        courseType: courseType ?? this.courseType,
        teacher: teacher ?? this.teacher,
        grade: grade ?? this.grade,
        compensation: compensation ?? this.compensation,
      );
  @override
  String toString() {
    return (StringBuffer('Course(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('beginTime: $beginTime, ')
          ..write('hour: $hour, ')
          ..write('subject: $subject, ')
          ..write('courseType: $courseType, ')
          ..write('teacher: $teacher, ')
          ..write('grade: $grade, ')
          ..write('compensation: $compensation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, dayOfWeek, beginTime, hour, subject,
      courseType, teacher, grade, compensation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          other.id == this.id &&
          other.date == this.date &&
          other.dayOfWeek == this.dayOfWeek &&
          other.beginTime == this.beginTime &&
          other.hour == this.hour &&
          other.subject == this.subject &&
          other.courseType == this.courseType &&
          other.teacher == this.teacher &&
          other.grade == this.grade &&
          other.compensation == this.compensation);
}

class CoursesCompanion extends UpdateCompanion<Course> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> dayOfWeek;
  final Value<String?> beginTime;
  final Value<double?> hour;
  final Value<String> subject;
  final Value<String> courseType;
  final Value<String> teacher;
  final Value<int> grade;
  final Value<int> compensation;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.beginTime = const Value.absent(),
    this.hour = const Value.absent(),
    this.subject = const Value.absent(),
    this.courseType = const Value.absent(),
    this.teacher = const Value.absent(),
    this.grade = const Value.absent(),
    this.compensation = const Value.absent(),
  });
  CoursesCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String dayOfWeek,
    this.beginTime = const Value.absent(),
    this.hour = const Value.absent(),
    required String subject,
    required String courseType,
    required String teacher,
    required int grade,
    required int compensation,
  })  : date = Value(date),
        dayOfWeek = Value(dayOfWeek),
        subject = Value(subject),
        courseType = Value(courseType),
        teacher = Value(teacher),
        grade = Value(grade),
        compensation = Value(compensation);
  static Insertable<Course> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? dayOfWeek,
    Expression<String>? beginTime,
    Expression<double>? hour,
    Expression<String>? subject,
    Expression<String>? courseType,
    Expression<String>? teacher,
    Expression<int>? grade,
    Expression<int>? compensation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (beginTime != null) 'begin_time': beginTime,
      if (hour != null) 'hour': hour,
      if (subject != null) 'subject': subject,
      if (courseType != null) 'course_type': courseType,
      if (teacher != null) 'teacher': teacher,
      if (grade != null) 'grade': grade,
      if (compensation != null) 'compensation': compensation,
    });
  }

  CoursesCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? dayOfWeek,
      Value<String?>? beginTime,
      Value<double?>? hour,
      Value<String>? subject,
      Value<String>? courseType,
      Value<String>? teacher,
      Value<int>? grade,
      Value<int>? compensation}) {
    return CoursesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      beginTime: beginTime ?? this.beginTime,
      hour: hour ?? this.hour,
      subject: subject ?? this.subject,
      courseType: courseType ?? this.courseType,
      teacher: teacher ?? this.teacher,
      grade: grade ?? this.grade,
      compensation: compensation ?? this.compensation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<String>(dayOfWeek.value);
    }
    if (beginTime.present) {
      map['begin_time'] = Variable<String>(beginTime.value);
    }
    if (hour.present) {
      map['hour'] = Variable<double>(hour.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (courseType.present) {
      map['course_type'] = Variable<String>(courseType.value);
    }
    if (teacher.present) {
      map['teacher'] = Variable<String>(teacher.value);
    }
    if (grade.present) {
      map['grade'] = Variable<int>(grade.value);
    }
    if (compensation.present) {
      map['compensation'] = Variable<int>(compensation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('beginTime: $beginTime, ')
          ..write('hour: $hour, ')
          ..write('subject: $subject, ')
          ..write('courseType: $courseType, ')
          ..write('teacher: $teacher, ')
          ..write('grade: $grade, ')
          ..write('compensation: $compensation')
          ..write(')'))
        .toString();
  }
}

class $StudentCoursesTable extends StudentCourses
    with TableInfo<$StudentCoursesTable, Student_Course> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentCoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _studentNameMeta =
      const VerificationMeta('studentName');
  @override
  late final GeneratedColumn<String> studentName = GeneratedColumn<String>(
      'student_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<int> grade = GeneratedColumn<int>(
      'grade', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _courseIdMeta =
      const VerificationMeta('courseId');
  @override
  late final GeneratedColumn<int> courseId = GeneratedColumn<int>(
      'course_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
      'price', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [studentName, grade, courseId, price];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_courses';
  @override
  VerificationContext validateIntegrity(Insertable<Student_Course> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('student_name')) {
      context.handle(
          _studentNameMeta,
          studentName.isAcceptableOrUnknown(
              data['student_name']!, _studentNameMeta));
    } else if (isInserting) {
      context.missing(_studentNameMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('course_id')) {
      context.handle(_courseIdMeta,
          courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta));
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {studentName, grade, courseId};
  @override
  Student_Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student_Course(
      studentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}student_name'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grade'])!,
      courseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}course_id'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price'])!,
    );
  }

  @override
  $StudentCoursesTable createAlias(String alias) {
    return $StudentCoursesTable(attachedDatabase, alias);
  }
}

class Student_Course extends DataClass implements Insertable<Student_Course> {
  final String studentName;
  final int grade;
  final int courseId;
  final int price;
  const Student_Course(
      {required this.studentName,
      required this.grade,
      required this.courseId,
      required this.price});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['student_name'] = Variable<String>(studentName);
    map['grade'] = Variable<int>(grade);
    map['course_id'] = Variable<int>(courseId);
    map['price'] = Variable<int>(price);
    return map;
  }

  StudentCoursesCompanion toCompanion(bool nullToAbsent) {
    return StudentCoursesCompanion(
      studentName: Value(studentName),
      grade: Value(grade),
      courseId: Value(courseId),
      price: Value(price),
    );
  }

  factory Student_Course.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student_Course(
      studentName: serializer.fromJson<String>(json['studentName']),
      grade: serializer.fromJson<int>(json['grade']),
      courseId: serializer.fromJson<int>(json['courseId']),
      price: serializer.fromJson<int>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'studentName': serializer.toJson<String>(studentName),
      'grade': serializer.toJson<int>(grade),
      'courseId': serializer.toJson<int>(courseId),
      'price': serializer.toJson<int>(price),
    };
  }

  Student_Course copyWith(
          {String? studentName, int? grade, int? courseId, int? price}) =>
      Student_Course(
        studentName: studentName ?? this.studentName,
        grade: grade ?? this.grade,
        courseId: courseId ?? this.courseId,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('Student_Course(')
          ..write('studentName: $studentName, ')
          ..write('grade: $grade, ')
          ..write('courseId: $courseId, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(studentName, grade, courseId, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student_Course &&
          other.studentName == this.studentName &&
          other.grade == this.grade &&
          other.courseId == this.courseId &&
          other.price == this.price);
}

class StudentCoursesCompanion extends UpdateCompanion<Student_Course> {
  final Value<String> studentName;
  final Value<int> grade;
  final Value<int> courseId;
  final Value<int> price;
  final Value<int> rowid;
  const StudentCoursesCompanion({
    this.studentName = const Value.absent(),
    this.grade = const Value.absent(),
    this.courseId = const Value.absent(),
    this.price = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentCoursesCompanion.insert({
    required String studentName,
    required int grade,
    required int courseId,
    required int price,
    this.rowid = const Value.absent(),
  })  : studentName = Value(studentName),
        grade = Value(grade),
        courseId = Value(courseId),
        price = Value(price);
  static Insertable<Student_Course> custom({
    Expression<String>? studentName,
    Expression<int>? grade,
    Expression<int>? courseId,
    Expression<int>? price,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (studentName != null) 'student_name': studentName,
      if (grade != null) 'grade': grade,
      if (courseId != null) 'course_id': courseId,
      if (price != null) 'price': price,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentCoursesCompanion copyWith(
      {Value<String>? studentName,
      Value<int>? grade,
      Value<int>? courseId,
      Value<int>? price,
      Value<int>? rowid}) {
    return StudentCoursesCompanion(
      studentName: studentName ?? this.studentName,
      grade: grade ?? this.grade,
      courseId: courseId ?? this.courseId,
      price: price ?? this.price,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (studentName.present) {
      map['student_name'] = Variable<String>(studentName.value);
    }
    if (grade.present) {
      map['grade'] = Variable<int>(grade.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<int>(courseId.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentCoursesCompanion(')
          ..write('studentName: $studentName, ')
          ..write('grade: $grade, ')
          ..write('courseId: $courseId, ')
          ..write('price: $price, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $StudentsTable students = $StudentsTable(this);
  late final $CoursesTable courses = $CoursesTable(this);
  late final $StudentCoursesTable studentCourses = $StudentCoursesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [students, courses, studentCourses];
}

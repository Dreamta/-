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
  static const VerificationMeta _registGradeMeta =
      const VerificationMeta('registGrade');
  @override
  late final GeneratedColumn<int> registGrade = GeneratedColumn<int>(
      'regist_grade', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _registYearMeta =
      const VerificationMeta('registYear');
  @override
  late final GeneratedColumn<int> registYear = GeneratedColumn<int>(
      'regist_year', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [name, registGrade, registYear];
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
    if (data.containsKey('regist_grade')) {
      context.handle(
          _registGradeMeta,
          registGrade.isAcceptableOrUnknown(
              data['regist_grade']!, _registGradeMeta));
    } else if (isInserting) {
      context.missing(_registGradeMeta);
    }
    if (data.containsKey('regist_year')) {
      context.handle(
          _registYearMeta,
          registYear.isAcceptableOrUnknown(
              data['regist_year']!, _registYearMeta));
    } else if (isInserting) {
      context.missing(_registYearMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name, registGrade, registYear};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      registGrade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}regist_grade'])!,
      registYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}regist_year'])!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final String name;
  final int registGrade;
  final int registYear;
  const Student(
      {required this.name,
      required this.registGrade,
      required this.registYear});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['regist_grade'] = Variable<int>(registGrade);
    map['regist_year'] = Variable<int>(registYear);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      name: Value(name),
      registGrade: Value(registGrade),
      registYear: Value(registYear),
    );
  }

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      name: serializer.fromJson<String>(json['name']),
      registGrade: serializer.fromJson<int>(json['registGrade']),
      registYear: serializer.fromJson<int>(json['registYear']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'registGrade': serializer.toJson<int>(registGrade),
      'registYear': serializer.toJson<int>(registYear),
    };
  }

  Student copyWith({String? name, int? registGrade, int? registYear}) =>
      Student(
        name: name ?? this.name,
        registGrade: registGrade ?? this.registGrade,
        registYear: registYear ?? this.registYear,
      );
  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('name: $name, ')
          ..write('registGrade: $registGrade, ')
          ..write('registYear: $registYear')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, registGrade, registYear);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.name == this.name &&
          other.registGrade == this.registGrade &&
          other.registYear == this.registYear);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<String> name;
  final Value<int> registGrade;
  final Value<int> registYear;
  final Value<int> rowid;
  const StudentsCompanion({
    this.name = const Value.absent(),
    this.registGrade = const Value.absent(),
    this.registYear = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentsCompanion.insert({
    required String name,
    required int registGrade,
    required int registYear,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        registGrade = Value(registGrade),
        registYear = Value(registYear);
  static Insertable<Student> custom({
    Expression<String>? name,
    Expression<int>? registGrade,
    Expression<int>? registYear,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (registGrade != null) 'regist_grade': registGrade,
      if (registYear != null) 'regist_year': registYear,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentsCompanion copyWith(
      {Value<String>? name,
      Value<int>? registGrade,
      Value<int>? registYear,
      Value<int>? rowid}) {
    return StudentsCompanion(
      name: name ?? this.name,
      registGrade: registGrade ?? this.registGrade,
      registYear: registYear ?? this.registYear,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (registGrade.present) {
      map['regist_grade'] = Variable<int>(registGrade.value);
    }
    if (registYear.present) {
      map['regist_year'] = Variable<int>(registYear.value);
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
          ..write('registGrade: $registGrade, ')
          ..write('registYear: $registYear, ')
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
      'compensation', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
          .read(DriftSqlType.int, data['${effectivePrefix}compensation']),
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
  final int? compensation;
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
      this.compensation});
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
    if (!nullToAbsent || compensation != null) {
      map['compensation'] = Variable<int>(compensation);
    }
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
      compensation: compensation == null && nullToAbsent
          ? const Value.absent()
          : Value(compensation),
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
      compensation: serializer.fromJson<int?>(json['compensation']),
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
      'compensation': serializer.toJson<int?>(compensation),
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
          Value<int?> compensation = const Value.absent()}) =>
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
        compensation:
            compensation.present ? compensation.value : this.compensation,
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
  final Value<int?> compensation;
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
    this.compensation = const Value.absent(),
  })  : date = Value(date),
        dayOfWeek = Value(dayOfWeek),
        subject = Value(subject),
        courseType = Value(courseType),
        teacher = Value(teacher),
        grade = Value(grade);
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
      Value<int?>? compensation}) {
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
  static const VerificationMeta _registGradeMeta =
      const VerificationMeta('registGrade');
  @override
  late final GeneratedColumn<int> registGrade = GeneratedColumn<int>(
      'regist_grade', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _registYearMeta =
      const VerificationMeta('registYear');
  @override
  late final GeneratedColumn<int> registYear = GeneratedColumn<int>(
      'regist_year', aliasedName, false,
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
      'price', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [studentName, registGrade, registYear, courseId, price];
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
    if (data.containsKey('regist_grade')) {
      context.handle(
          _registGradeMeta,
          registGrade.isAcceptableOrUnknown(
              data['regist_grade']!, _registGradeMeta));
    } else if (isInserting) {
      context.missing(_registGradeMeta);
    }
    if (data.containsKey('regist_year')) {
      context.handle(
          _registYearMeta,
          registYear.isAcceptableOrUnknown(
              data['regist_year']!, _registYearMeta));
    } else if (isInserting) {
      context.missing(_registYearMeta);
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey =>
      {studentName, registGrade, registYear, courseId};
  @override
  Student_Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student_Course(
      studentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}student_name'])!,
      registGrade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}regist_grade'])!,
      registYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}regist_year'])!,
      courseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}course_id'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price']),
    );
  }

  @override
  $StudentCoursesTable createAlias(String alias) {
    return $StudentCoursesTable(attachedDatabase, alias);
  }
}

class Student_Course extends DataClass implements Insertable<Student_Course> {
  final String studentName;
  final int registGrade;
  final int registYear;
  final int courseId;
  final int? price;
  const Student_Course(
      {required this.studentName,
      required this.registGrade,
      required this.registYear,
      required this.courseId,
      this.price});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['student_name'] = Variable<String>(studentName);
    map['regist_grade'] = Variable<int>(registGrade);
    map['regist_year'] = Variable<int>(registYear);
    map['course_id'] = Variable<int>(courseId);
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    return map;
  }

  StudentCoursesCompanion toCompanion(bool nullToAbsent) {
    return StudentCoursesCompanion(
      studentName: Value(studentName),
      registGrade: Value(registGrade),
      registYear: Value(registYear),
      courseId: Value(courseId),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
    );
  }

  factory Student_Course.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student_Course(
      studentName: serializer.fromJson<String>(json['studentName']),
      registGrade: serializer.fromJson<int>(json['registGrade']),
      registYear: serializer.fromJson<int>(json['registYear']),
      courseId: serializer.fromJson<int>(json['courseId']),
      price: serializer.fromJson<int?>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'studentName': serializer.toJson<String>(studentName),
      'registGrade': serializer.toJson<int>(registGrade),
      'registYear': serializer.toJson<int>(registYear),
      'courseId': serializer.toJson<int>(courseId),
      'price': serializer.toJson<int?>(price),
    };
  }

  Student_Course copyWith(
          {String? studentName,
          int? registGrade,
          int? registYear,
          int? courseId,
          Value<int?> price = const Value.absent()}) =>
      Student_Course(
        studentName: studentName ?? this.studentName,
        registGrade: registGrade ?? this.registGrade,
        registYear: registYear ?? this.registYear,
        courseId: courseId ?? this.courseId,
        price: price.present ? price.value : this.price,
      );
  @override
  String toString() {
    return (StringBuffer('Student_Course(')
          ..write('studentName: $studentName, ')
          ..write('registGrade: $registGrade, ')
          ..write('registYear: $registYear, ')
          ..write('courseId: $courseId, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(studentName, registGrade, registYear, courseId, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student_Course &&
          other.studentName == this.studentName &&
          other.registGrade == this.registGrade &&
          other.registYear == this.registYear &&
          other.courseId == this.courseId &&
          other.price == this.price);
}

class StudentCoursesCompanion extends UpdateCompanion<Student_Course> {
  final Value<String> studentName;
  final Value<int> registGrade;
  final Value<int> registYear;
  final Value<int> courseId;
  final Value<int?> price;
  final Value<int> rowid;
  const StudentCoursesCompanion({
    this.studentName = const Value.absent(),
    this.registGrade = const Value.absent(),
    this.registYear = const Value.absent(),
    this.courseId = const Value.absent(),
    this.price = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentCoursesCompanion.insert({
    required String studentName,
    required int registGrade,
    required int registYear,
    required int courseId,
    this.price = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : studentName = Value(studentName),
        registGrade = Value(registGrade),
        registYear = Value(registYear),
        courseId = Value(courseId);
  static Insertable<Student_Course> custom({
    Expression<String>? studentName,
    Expression<int>? registGrade,
    Expression<int>? registYear,
    Expression<int>? courseId,
    Expression<int>? price,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (studentName != null) 'student_name': studentName,
      if (registGrade != null) 'regist_grade': registGrade,
      if (registYear != null) 'regist_year': registYear,
      if (courseId != null) 'course_id': courseId,
      if (price != null) 'price': price,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentCoursesCompanion copyWith(
      {Value<String>? studentName,
      Value<int>? registGrade,
      Value<int>? registYear,
      Value<int>? courseId,
      Value<int?>? price,
      Value<int>? rowid}) {
    return StudentCoursesCompanion(
      studentName: studentName ?? this.studentName,
      registGrade: registGrade ?? this.registGrade,
      registYear: registYear ?? this.registYear,
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
    if (registGrade.present) {
      map['regist_grade'] = Variable<int>(registGrade.value);
    }
    if (registYear.present) {
      map['regist_year'] = Variable<int>(registYear.value);
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
          ..write('registGrade: $registGrade, ')
          ..write('registYear: $registYear, ')
          ..write('courseId: $courseId, ')
          ..write('price: $price, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeachersTable extends Teachers with TableInfo<$TeachersTable, Teacher> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeachersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teachers';
  @override
  VerificationContext validateIntegrity(Insertable<Teacher> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Teacher map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Teacher(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $TeachersTable createAlias(String alias) {
    return $TeachersTable(attachedDatabase, alias);
  }
}

class Teacher extends DataClass implements Insertable<Teacher> {
  final String name;
  const Teacher({required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    return map;
  }

  TeachersCompanion toCompanion(bool nullToAbsent) {
    return TeachersCompanion(
      name: Value(name),
    );
  }

  factory Teacher.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Teacher(
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
    };
  }

  Teacher copyWith({String? name}) => Teacher(
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Teacher(')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => name.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Teacher && other.name == this.name);
}

class TeachersCompanion extends UpdateCompanion<Teacher> {
  final Value<String> name;
  final Value<int> rowid;
  const TeachersCompanion({
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeachersCompanion.insert({
    required String name,
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Teacher> custom({
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeachersCompanion copyWith({Value<String>? name, Value<int>? rowid}) {
    return TeachersCompanion(
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeachersCompanion(')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudentTeacherTable extends StudentTeacher
    with TableInfo<$StudentTeacherTable, Student_Teacher> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentTeacherTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _studentNameMeta =
      const VerificationMeta('studentName');
  @override
  late final GeneratedColumn<String> studentName = GeneratedColumn<String>(
      'student_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _registGradeMeta =
      const VerificationMeta('registGrade');
  @override
  late final GeneratedColumn<int> registGrade = GeneratedColumn<int>(
      'regist_grade', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _registYearMeta =
      const VerificationMeta('registYear');
  @override
  late final GeneratedColumn<int> registYear = GeneratedColumn<int>(
      'regist_year', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _teacherNameMeta =
      const VerificationMeta('teacherName');
  @override
  late final GeneratedColumn<String> teacherName = GeneratedColumn<String>(
      'teacher_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [studentName, registGrade, registYear, teacherName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_teacher';
  @override
  VerificationContext validateIntegrity(Insertable<Student_Teacher> instance,
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
    if (data.containsKey('regist_grade')) {
      context.handle(
          _registGradeMeta,
          registGrade.isAcceptableOrUnknown(
              data['regist_grade']!, _registGradeMeta));
    } else if (isInserting) {
      context.missing(_registGradeMeta);
    }
    if (data.containsKey('regist_year')) {
      context.handle(
          _registYearMeta,
          registYear.isAcceptableOrUnknown(
              data['regist_year']!, _registYearMeta));
    } else if (isInserting) {
      context.missing(_registYearMeta);
    }
    if (data.containsKey('teacher_name')) {
      context.handle(
          _teacherNameMeta,
          teacherName.isAcceptableOrUnknown(
              data['teacher_name']!, _teacherNameMeta));
    } else if (isInserting) {
      context.missing(_teacherNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey =>
      {studentName, registGrade, registYear, teacherName};
  @override
  Student_Teacher map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student_Teacher(
      studentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}student_name'])!,
      registGrade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}regist_grade'])!,
      registYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}regist_year'])!,
      teacherName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}teacher_name'])!,
    );
  }

  @override
  $StudentTeacherTable createAlias(String alias) {
    return $StudentTeacherTable(attachedDatabase, alias);
  }
}

class Student_Teacher extends DataClass implements Insertable<Student_Teacher> {
  final String studentName;
  final int registGrade;
  final int registYear;
  final String teacherName;
  const Student_Teacher(
      {required this.studentName,
      required this.registGrade,
      required this.registYear,
      required this.teacherName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['student_name'] = Variable<String>(studentName);
    map['regist_grade'] = Variable<int>(registGrade);
    map['regist_year'] = Variable<int>(registYear);
    map['teacher_name'] = Variable<String>(teacherName);
    return map;
  }

  StudentTeacherCompanion toCompanion(bool nullToAbsent) {
    return StudentTeacherCompanion(
      studentName: Value(studentName),
      registGrade: Value(registGrade),
      registYear: Value(registYear),
      teacherName: Value(teacherName),
    );
  }

  factory Student_Teacher.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student_Teacher(
      studentName: serializer.fromJson<String>(json['studentName']),
      registGrade: serializer.fromJson<int>(json['registGrade']),
      registYear: serializer.fromJson<int>(json['registYear']),
      teacherName: serializer.fromJson<String>(json['teacherName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'studentName': serializer.toJson<String>(studentName),
      'registGrade': serializer.toJson<int>(registGrade),
      'registYear': serializer.toJson<int>(registYear),
      'teacherName': serializer.toJson<String>(teacherName),
    };
  }

  Student_Teacher copyWith(
          {String? studentName,
          int? registGrade,
          int? registYear,
          String? teacherName}) =>
      Student_Teacher(
        studentName: studentName ?? this.studentName,
        registGrade: registGrade ?? this.registGrade,
        registYear: registYear ?? this.registYear,
        teacherName: teacherName ?? this.teacherName,
      );
  @override
  String toString() {
    return (StringBuffer('Student_Teacher(')
          ..write('studentName: $studentName, ')
          ..write('registGrade: $registGrade, ')
          ..write('registYear: $registYear, ')
          ..write('teacherName: $teacherName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(studentName, registGrade, registYear, teacherName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student_Teacher &&
          other.studentName == this.studentName &&
          other.registGrade == this.registGrade &&
          other.registYear == this.registYear &&
          other.teacherName == this.teacherName);
}

class StudentTeacherCompanion extends UpdateCompanion<Student_Teacher> {
  final Value<String> studentName;
  final Value<int> registGrade;
  final Value<int> registYear;
  final Value<String> teacherName;
  final Value<int> rowid;
  const StudentTeacherCompanion({
    this.studentName = const Value.absent(),
    this.registGrade = const Value.absent(),
    this.registYear = const Value.absent(),
    this.teacherName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentTeacherCompanion.insert({
    required String studentName,
    required int registGrade,
    required int registYear,
    required String teacherName,
    this.rowid = const Value.absent(),
  })  : studentName = Value(studentName),
        registGrade = Value(registGrade),
        registYear = Value(registYear),
        teacherName = Value(teacherName);
  static Insertable<Student_Teacher> custom({
    Expression<String>? studentName,
    Expression<int>? registGrade,
    Expression<int>? registYear,
    Expression<String>? teacherName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (studentName != null) 'student_name': studentName,
      if (registGrade != null) 'regist_grade': registGrade,
      if (registYear != null) 'regist_year': registYear,
      if (teacherName != null) 'teacher_name': teacherName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentTeacherCompanion copyWith(
      {Value<String>? studentName,
      Value<int>? registGrade,
      Value<int>? registYear,
      Value<String>? teacherName,
      Value<int>? rowid}) {
    return StudentTeacherCompanion(
      studentName: studentName ?? this.studentName,
      registGrade: registGrade ?? this.registGrade,
      registYear: registYear ?? this.registYear,
      teacherName: teacherName ?? this.teacherName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (studentName.present) {
      map['student_name'] = Variable<String>(studentName.value);
    }
    if (registGrade.present) {
      map['regist_grade'] = Variable<int>(registGrade.value);
    }
    if (registYear.present) {
      map['regist_year'] = Variable<int>(registYear.value);
    }
    if (teacherName.present) {
      map['teacher_name'] = Variable<String>(teacherName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentTeacherCompanion(')
          ..write('studentName: $studentName, ')
          ..write('registGrade: $registGrade, ')
          ..write('registYear: $registYear, ')
          ..write('teacherName: $teacherName, ')
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
  late final $TeachersTable teachers = $TeachersTable(this);
  late final $StudentTeacherTable studentTeacher = $StudentTeacherTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [students, courses, studentCourses, teachers, studentTeacher];
}

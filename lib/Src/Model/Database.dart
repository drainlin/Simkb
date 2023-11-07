import 'package:simkb/Src/Model/Local/GradeModel.dart';
import 'package:simkb/Src/Model/Local/SocialExamModel.dart';
import 'package:simkb/Src/Response/ClassTableModel.dart';
import 'package:simkb/Src/Response/ExamsModel.dart';
import 'package:simkb/Src/Response/GradesModel.dart';
import 'package:simkb/Src/Response/SocialExamsModel.dart';
import 'package:simkb/Src/Response/UserInfoModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Local/ExamModel.dart';

class DatabaseHelper {
  static const _databaseName = 'simdb.db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    birthday TEXT,
    academyName TEXT,
    userNo TEXT,
    entranceYear TEXT,
    clsName TEXT,
    userType TEXT,
    token TEXT
  )
''');
    await db.execute('''
  CREATE TABLE grades (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    curriculumAttributes TEXT,
    courseName TEXT,
    courseNature TEXT,
    examinationNature TEXT,
    kcbh TEXT,
    credit REAL,
    cj0708id TEXT,
    fraction TEXT
  )
''');
    await db.execute('''
  CREATE TABLE courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    week TEXT,
    classWeek TEXT,
    teacherName TEXT,
    weekNoteDetail TEXT,
    buttonCode TEXT,
    xkrs INTEGER,
    ktmc TEXT,
    classTime TEXT,
    classroomNub TEXT,
    jx0408id TEXT,
    buildingName TEXT,
    courseName TEXT,
    isRepeatCode TEXT,
    jx0404id TEXT,
    weekDay TEXT,
    classroomName TEXT,
    startTime TEXT,
    endTime TEXT,
    location TEXT,
    fzmc TEXT,
    classWeekDetails TEXT,
    coursesNote INTEGER
  )
''');
    await db.execute('''
  CREATE TABLE socialgrades (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT,
    courseName TEXT,
    socialExaminationGradeName TEXT,
    skcjid TEXT,
    writtenTestScore TEXT,
    admissionTicketNumber TEXT,
    practiceScore TEXT,
    overallResult TEXT
  )
''');
    await db.execute('''
  CREATE TABLE exams (
    id INTEGER PRIMARY KEY AUTOINCREMENT ,
    courseName TEXT,
    examinationPlace TEXT,
    time TEXT
  )
''');
  }

  void insertUser(UserInfoModel data) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      'name': data.name,
      'birthday': data.birthday,
      'academyName': data.academyName,
      'userNo': data.userNo,
      'entranceYear': data.entranceYear,
      'clsName': data.clsName,
      'userType': data.userType,
      'token': data.token
    };
    await db.insert('users', row);
  }

  void clearUser() async {
    Database db = await instance.database;
    await db.delete('users');
  }

  void insertGrade(GradesModel data) async {
    Database db = await instance.database;

    if (data.data == null || data.data!.first.achievement == null) {
      return;
    }
    for (var element in data.data!.first.achievement!) {
      Map<String, dynamic> row = {
        'curriculumAttributes': element.curriculumAttributes,
        'courseName': element.courseName,
        'courseNature': element.courseNature,
        'examinationNature': element.examinationNature,
        'kcbh': element.kcbh,
        'credit': element.credit,
        'cj0708id': element.cj0708id,
        'fraction': element.fraction
      };
      await db.insert('grades', row);
    }
  }

  void clearGrade() async {
    Database db = await instance.database;
    await db.delete('grades');
  }

  void insertExams(ExamsModel data) async {
    Database db = await instance.database;
    if (data.data == null) {
      return;
    }
    for (var element in data.data!) {
      Map<String, dynamic> row = {
        'courseName': element.courseName,
        'examinationPlace': element.examinationPlace,
        'time': element.time
      };
      await db.insert('exams', row);
    }
  }

  void clearExams() async {
    Database db = await instance.database;
    await db.delete('exams');
  }

  void insertSocialExams(SocialExamsModel data) async {
    Database db = await instance.database;
    if (data.data == null) {
      return;
    }
    for (var element in data.data!) {
      Map<String, dynamic> row = {
        'date': element.date,
        'courseName': element.courseName,
        'socialExaminationGradeName': element.socialExaminationGradeName,
        'skcjid': element.skcjid,
        'writtenTestScore': element.writtenTestScore,
        'admissionTicketNumber': element.admissionTicketNumber,
        'practiceScore': element.practiceScore,
        'overallResult': element.overallResult
      };
      db.insert('socialgrades', row);
    }
  }

  void clearSocialExams() async {
    Database db = await instance.database;
    await db.delete('socialgrades');
  }

  void insertClassTable(ClassTableModel data) async {
    Database db = await instance.database;
    if (data.data == null || data.data!.first.courses == null) {
      return;
    }
    final week = data.data!.first.week.toString();
    for (var element in data.data!.first.courses!) {
      Map<String, dynamic> row = {
        'week': week,
        'classWeek': element.classWeek,
        'teacherName': element.teacherName,
        'weekNoteDetail': element.weekNoteDetail,
        'buttonCode': element.buttonCode,
        'xkrs': element.xkrs,
        'ktmc': element.ktmc,
        'classTime': element.classTime,
        'classroomNub': element.classroomNub,
        'jx0408id': element.jx0408id,
        'buildingName': element.buildingName,
        'courseName': element.courseName,
        'isRepeatCode': element.isRepeatCode,
        'jx0404id': element.jx0404id,
        'weekDay': element.weekDay,
        'classroomName': element.classroomName,
        'startTime': element.startTime,
        'endTime': element.endTIme,
        'location': element.location,
        'fzmc': element.fzmc,
        'classWeekDetails': element.classWeekDetails,
        'coursesNote': element.coursesNote
      };
      await db.insert('courses', row);
    }
  }

  void clearClassTable() async {
    Database db = await instance.database;
    await db.delete('courses');
  }

  Future<UserInfoModel> getUserInfo() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return UserInfoModel.fromJson(maps.first);
  }

  Future<List<GradeModel>> getGrades() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('grades');
    return List.generate(maps.length, (i) {
      return GradeModel.fromJson(maps[i]);
    });
  }

  Future<List<ExamModel>> getExams() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('exams');
    return List.generate(maps.length, (i) {
      return ExamModel.fromJson(maps[i]);
    });
  }

  Future<List<SocialExamModel>> getSocialExams() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('socialgrades');
    return List.generate(maps.length, (i) {
      return SocialExamModel.fromJson(maps[i]);
    });
  }

  Future<List<ClassTableModel>> getClassTable() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('courses');
    return List.generate(maps.length, (i) {
      return ClassTableModel.fromJson(maps[i]);
    });
  }
}

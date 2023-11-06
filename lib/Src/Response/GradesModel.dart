class GradesModel {
  String? _msg;
  String? _code;
  List<Data>? _data;

  GradesModel({String? msg, String? code, List<Data>? data}) {
    if (msg != null) {
      _msg = msg;
    }
    if (code != null) {
      _code = code;
    }
    if (data != null) {
      _data = data;
    }
  }

  String? get msg => _msg;

  set msg(String? msg) => _msg = msg;

  String? get code => _code;

  set code(String? code) => _code = code;

  List<Data>? get data => _data;

  set data(List<Data>? data) => _data = data;

  GradesModel.fromJson(Map<String, dynamic> json) {
    _msg = json['Msg'];
    _code = json['code'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Msg'] = _msg;
    data['code'] = _code;
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? _studentID;
  String? _pjcj;
  List<Achievement>? _achievement;
  String? _name;
  String? _yxzxf;
  String? _zxfjd;
  String? _pjxfjd;

  Data(
      {String? studentID,
      List<void>? xqgpa,
      String? pjcj,
      List<Achievement>? achievement,
      String? name,
      String? yxzxf,
      String? zxfjd,
      String? pjxfjd}) {
    if (studentID != null) {
      _studentID = studentID;
    }
    if (pjcj != null) {
      _pjcj = pjcj;
    }
    if (achievement != null) {
      _achievement = achievement;
    }
    if (name != null) {
      _name = name;
    }
    if (yxzxf != null) {
      _yxzxf = yxzxf;
    }
    if (zxfjd != null) {
      _zxfjd = zxfjd;
    }
    if (pjxfjd != null) {
      _pjxfjd = pjxfjd;
    }
  }

  String? get studentID => _studentID;

  set studentID(String? studentID) => _studentID = studentID;

  String? get pjcj => _pjcj;

  set pjcj(String? pjcj) => _pjcj = pjcj;

  List<Achievement>? get achievement => _achievement;

  set achievement(List<Achievement>? achievement) => _achievement = achievement;

  String? get name => _name;

  set name(String? name) => _name = name;

  String? get yxzxf => _yxzxf;

  set yxzxf(String? yxzxf) => _yxzxf = yxzxf;

  String? get zxfjd => _zxfjd;

  set zxfjd(String? zxfjd) => _zxfjd = zxfjd;

  String? get pjxfjd => _pjxfjd;

  set pjxfjd(String? pjxfjd) => _pjxfjd = pjxfjd;

  Data.fromJson(Map<String, dynamic> json) {
    _studentID = json['studentID'];

    _pjcj = json['pjcj'];
    if (json['achievement'] != null) {
      _achievement = <Achievement>[];
      json['achievement'].forEach((v) {
        _achievement!.add(Achievement.fromJson(v));
      });
    }
    _name = json['name'];
    _yxzxf = json['yxzxf'];
    _zxfjd = json['zxfjd'];
    _pjxfjd = json['pjxfjd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentID'] = _studentID;

    data['pjcj'] = _pjcj;
    if (_achievement != null) {
      data['achievement'] = _achievement!.map((v) => v.toJson()).toList();
    }
    data['name'] = _name;
    data['yxzxf'] = _yxzxf;
    data['zxfjd'] = _zxfjd;
    data['pjxfjd'] = _pjxfjd;
    return data;
  }
}

class Achievement {
  String? _curriculumAttributes;
  String? _courseName;
  String? _courseNature;
  String? _examinationNature;
  String? _kcbh;
  double? _credit;
  String? _cj0708id;
  String? _fraction;

  Achievement(
      {String? curriculumAttributes,
      String? courseName,
      String? courseNature,
      String? examinationNature,
      String? kcbh,
      double? credit,
      String? cj0708id,
      String? fraction}) {
    if (curriculumAttributes != null) {
      _curriculumAttributes = curriculumAttributes;
    }
    if (courseName != null) {
      _courseName = courseName;
    }
    if (courseNature != null) {
      _courseNature = courseNature;
    }
    if (examinationNature != null) {
      _examinationNature = examinationNature;
    }
    if (kcbh != null) {
      _kcbh = kcbh;
    }
    if (credit != null) {
      _credit = credit;
    }
    if (cj0708id != null) {
      _cj0708id = cj0708id;
    }
    if (fraction != null) {
      _fraction = fraction;
    }
  }

  String? get curriculumAttributes => _curriculumAttributes;

  set curriculumAttributes(String? curriculumAttributes) =>
      _curriculumAttributes = curriculumAttributes;

  String? get courseName => _courseName;

  set courseName(String? courseName) => _courseName = courseName;

  String? get courseNature => _courseNature;

  set courseNature(String? courseNature) => _courseNature = courseNature;

  String? get examinationNature => _examinationNature;

  set examinationNature(String? examinationNature) =>
      _examinationNature = examinationNature;

  String? get kcbh => _kcbh;

  set kcbh(String? kcbh) => _kcbh = kcbh;

  double? get credit => _credit;

  set credit(double? credit) => _credit = credit;

  String? get cj0708id => _cj0708id;

  set cj0708id(String? cj0708id) => _cj0708id = cj0708id;

  String? get fraction => _fraction;

  set fraction(String? fraction) => _fraction = fraction;

  Achievement.fromJson(Map<String, dynamic> json) {
    _curriculumAttributes = json['curriculumAttributes'];
    _courseName = json['courseName'];
    _courseNature = json['courseNature'];
    _examinationNature = json['examinationNature'];
    _kcbh = json['kcbh'];
    _credit = json['credit'];
    _cj0708id = json['cj0708id'];
    _fraction = json['fraction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['curriculumAttributes'] = _curriculumAttributes;
    data['courseName'] = _courseName;
    data['courseNature'] = _courseNature;
    data['examinationNature'] = _examinationNature;
    data['kcbh'] = _kcbh;
    data['credit'] = _credit;
    data['cj0708id'] = _cj0708id;
    data['fraction'] = _fraction;
    return data;
  }
}

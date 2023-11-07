class GradeModel {
  String? _curriculumAttributes;
  String? _courseName;
  String? _courseNature;
  String? _examinationNature;
  String? _kcbh;
  double? _credit;
  String? _cj0708id;
  String? _fraction;

  GradeModel(
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

  GradeModel.fromJson(Map<String, dynamic> json) {
    _curriculumAttributes = json['curriculumAttributes'];
    _courseName = json['courseName'];
    _courseNature = json['courseNature'];
    _examinationNature = json['examinationNature'];
    _kcbh = json['kcbh'];
    _credit = json['credit'].toDouble();
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

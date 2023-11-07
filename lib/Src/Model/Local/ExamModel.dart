class ExamModel {
  String? _courseName;
  String? _examinationPlace;
  String? _time;

  ExamModel({String? courseName, String? examinationPlace, String? time}) {
    if (courseName != null) {
      _courseName = courseName;
    }
    if (examinationPlace != null) {
      _examinationPlace = examinationPlace;
    }
    if (time != null) {
      _time = time;
    }
  }

  String? get courseName => _courseName;
  set courseName(String? courseName) => _courseName = courseName;
  String? get examinationPlace => _examinationPlace;
  set examinationPlace(String? examinationPlace) =>
      _examinationPlace = examinationPlace;
  String? get time => _time;
  set time(String? time) => _time = time;

  ExamModel.fromJson(Map<String, dynamic> json) {
    _courseName = json['courseName'];
    _examinationPlace = json['examinationPlace'];
    _time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseName'] = _courseName;
    data['examinationPlace'] = _examinationPlace;
    data['time'] = _time;
    return data;
  }
}

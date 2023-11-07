class SocialExamModel {
  String? _date;
  String? _courseName;
  String? _socialExaminationGradeName;
  String? _skcjid;
  String? _writtenTestScore;
  String? _admissionTicketNumber;
  String? _practiceScore;
  String? _overallResult;

  SocialExamModel(
      {String? date,
      String? courseName,
      String? socialExaminationGradeName,
      String? skcjid,
      String? writtenTestScore,
      String? admissionTicketNumber,
      String? practiceScore,
      String? overallResult}) {
    if (date != null) {
      _date = date;
    }
    if (courseName != null) {
      _courseName = courseName;
    }
    if (socialExaminationGradeName != null) {
      _socialExaminationGradeName = socialExaminationGradeName;
    }
    if (skcjid != null) {
      _skcjid = skcjid;
    }
    if (writtenTestScore != null) {
      _writtenTestScore = writtenTestScore;
    }
    if (admissionTicketNumber != null) {
      _admissionTicketNumber = admissionTicketNumber;
    }
    if (practiceScore != null) {
      _practiceScore = practiceScore;
    }
    if (overallResult != null) {
      _overallResult = overallResult;
    }
  }

  String? get date => _date;
  set date(String? date) => _date = date;
  String? get courseName => _courseName;
  set courseName(String? courseName) => _courseName = courseName;
  String? get socialExaminationGradeName => _socialExaminationGradeName;
  set socialExaminationGradeName(String? socialExaminationGradeName) =>
      _socialExaminationGradeName = socialExaminationGradeName;
  String? get skcjid => _skcjid;
  set skcjid(String? skcjid) => _skcjid = skcjid;
  String? get writtenTestScore => _writtenTestScore;
  set writtenTestScore(String? writtenTestScore) =>
      _writtenTestScore = writtenTestScore;
  String? get admissionTicketNumber => _admissionTicketNumber;
  set admissionTicketNumber(String? admissionTicketNumber) =>
      _admissionTicketNumber = admissionTicketNumber;
  String? get practiceScore => _practiceScore;
  set practiceScore(String? practiceScore) => _practiceScore = practiceScore;
  String? get overallResult => _overallResult;
  set overallResult(String? overallResult) => _overallResult = overallResult;

  SocialExamModel.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _courseName = json['courseName'];
    _socialExaminationGradeName = json['socialExaminationGradeName'];
    _skcjid = json['skcjid'];
    _writtenTestScore = json['writtenTestScore'];
    _admissionTicketNumber = json['admissionTicketNumber'];
    _practiceScore = json['practiceScore'];
    _overallResult = json['overallResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = _date;
    data['courseName'] = _courseName;
    data['socialExaminationGradeName'] = _socialExaminationGradeName;
    data['skcjid'] = _skcjid;
    data['writtenTestScore'] = _writtenTestScore;
    data['admissionTicketNumber'] = _admissionTicketNumber;
    data['practiceScore'] = _practiceScore;
    data['overallResult'] = _overallResult;
    return data;
  }
}

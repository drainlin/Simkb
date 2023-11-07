class TermModel {
  String? _semesterId;
  String? _semesterName;

  TermModel({String? semesterId, String? semesterName}) {
    if (semesterId != null) {
      _semesterId = semesterId;
    }
    if (semesterName != null) {
      _semesterName = semesterName;
    }
  }

  String? get semesterId => _semesterId;
  set semesterId(String? semesterId) => _semesterId = semesterId;
  String? get semesterName => _semesterName;
  set semesterName(String? semesterName) => _semesterName = semesterName;

  TermModel.fromJson(Map<String, dynamic> json) {
    _semesterId = json['semesterId'];
    _semesterName = json['semesterName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['semesterId'] = _semesterId;
    data['semesterName'] = _semesterName;
    return data;
  }
}

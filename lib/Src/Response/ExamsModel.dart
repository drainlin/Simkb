class ExamsModel {
  String? _msg;
  String? _code;
  List<Data>? _data;

  ExamsModel({String? msg, String? code, List<Data>? data}) {
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

  ExamsModel.fromJson(Map<String, dynamic> json) {
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
  String? _courseName;
  String? _examinationPlace;
  String? _time;

  Data({String? courseName, String? examinationPlace, String? time}) {
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

  Data.fromJson(Map<String, dynamic> json) {
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

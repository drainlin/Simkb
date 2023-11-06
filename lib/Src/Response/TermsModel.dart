class TermsModel {
  String? _code;
  String? _msg;
  List<Data>? _data;

  TermsModel({String? code, String? msg, List<Data>? data}) {
    if (code != null) {
      _code = code;
    }
    if (msg != null) {
      _msg = msg;
    }
    if (data != null) {
      _data = data;
    }
  }

  String? get code => _code;
  set code(String? code) => _code = code;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;

  TermsModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _msg = json['Msg'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = _code;
    data['Msg'] = _msg;
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? _semesterId;
  String? _semesterName;

  Data({String? semesterId, String? semesterName}) {
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

  Data.fromJson(Map<String, dynamic> json) {
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

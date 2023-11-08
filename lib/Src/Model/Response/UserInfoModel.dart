class UserInfoModel {
  String? _birthday;
  String? _academyName;
  String? _userNo;
  String? _entranceYear;
  String? _clsName;
  String? _name;
  String? _userType;
  String? _token;

  UserInfoModel(
      {String? birthday,
      String? academyName,
      String? userNo,
      String? entranceYear,
      String? clsName,
      String? name,
      String? userType,
      String? token}) {
    if (birthday != null) {
      _birthday = birthday;
    }
    if (academyName != null) {
      _academyName = academyName;
    }
    if (userNo != null) {
      _userNo = userNo;
    }
    if (entranceYear != null) {
      _entranceYear = entranceYear;
    }
    if (clsName != null) {
      _clsName = clsName;
    }
    if (name != null) {
      _name = name;
    }
    if (userType != null) {
      _userType = userType;
    }
    if (token != null) {
      _token = token;
    }
  }

  String? get birthday => _birthday;

  set birthday(String? birthday) => _birthday = birthday;

  String? get academyName => _academyName;

  set academyName(String? academyName) => _academyName = academyName;

  String? get userNo => _userNo;

  set userNo(String? userNo) => _userNo = userNo;

  String? get entranceYear => _entranceYear;

  set entranceYear(String? entranceYear) => _entranceYear = entranceYear;

  String? get clsName => _clsName;

  set clsName(String? clsName) => _clsName = clsName;

  String? get name => _name;

  set name(String? name) => _name = name;

  String? get userType => _userType;

  set userType(String? userType) => _userType = userType;

  String? get token => _token;

  set token(String? token) => _token = token;

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    _birthday = json['birthday'];
    _academyName = json['academyName'];
    _userNo = json['userNo'];
    _entranceYear = json['entranceYear'];
    _clsName = json['clsName'];
    _name = json['name'];
    _userType = json['userType'];
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birthday'] = _birthday;
    data['academyName'] = _academyName;
    data['userNo'] = _userNo;
    data['entranceYear'] = _entranceYear;
    data['clsName'] = _clsName;
    data['name'] = _name;
    data['userType'] = _userType;
    data['token'] = _token;
    return data;
  }
}

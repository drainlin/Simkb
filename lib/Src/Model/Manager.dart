import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:simkb/Src/Model/Database.dart';
import 'package:simkb/Src/Model/Encrypt.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:simkb/Src/Model/Localstorage.dart';
import 'package:simkb/Src/Response/ClassTableModel.dart';
import 'package:simkb/Src/Response/ExamsModel.dart';
import 'package:simkb/Src/Response/GradesModel.dart';
import 'package:simkb/Src/Response/SocialExamsModel.dart';
import 'package:simkb/Src/Response/TermsModel.dart';
import 'package:simkb/Src/Response/UserInfoModel.dart';
import 'package:simkb/Src/Utility/Global.dart';
import 'package:simkb/Src/Utility/Service.dart';
import '../Utility/Tool.dart';

final _Dio = Dio();

class Manager {
  Manager._() {
    // _prepareForFiddler();
  }
  static const _loginURL =
      "https://cas.paas.cdut.edu.cn/cas/login?service=http%3A%2F%2Fmjw.cdut.edu.cn%2Fcdlgdxhd%2FloginSso&redirect_uri=http%3A%2F%2Fpaym-cdut-edu-cn.vpn.cdut.edu.cn%3A8118%2FcasLogin%2F";

  final cookieJar = CookieJar();
  static final Manager _instance = Manager._();
  factory Manager() {
    return _instance;
  }

  void _prepareForFiddler() {
    if (!kDebugMode) return;
    (_Dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.findProxy = (url) {
        return "PROXY 192.168.10.114:8888";
      };
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return null;
    };
  }

  String _matchLocation(String location) {
    if (location.isNotEmpty) {
      return location.substring(1, location.length - 1);
    } else {
      return "";
    }
  }

  String _matchToken(String text) {
    const tokenPattern = "token=([^&']+)";
    final match = RegExp(tokenPattern).firstMatch(text);
    if (match != null) {
      final token = match.group(1);
      return token!;
    } else {
      Tool.printLog("No token found in the text.");
      return "";
    }
  }

  Future<(bool, String)> getToken(String username, String password) async {
    try {
      await cookieJar.deleteAll();
      _Dio.interceptors.add(CookieManager(cookieJar));
      String rsaPassword = await Encrypt.encrypt(password);
      final data = {
        "username": username,
        "password": rsaPassword,
        "captcha": "",
        "currentMenu": "1",
        "failN": "0",
        "execution": "e1s1",
        "_eventId": "submit",
        "geolocation": "",
        "submit": "稍等片刻……"
      };
      final postOptions = Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          });
      final getOptions = Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          });
      var result = await _Dio.post(
        _loginURL,
        data: data,
        options: postOptions,
      );
      await _Dio.get(_loginURL, options: getOptions);
      result = await _Dio.post(
        _loginURL,
        data: data,
        options: postOptions,
      );
      if (result.statusCode == 401) throw Exception("用户名或密码错误");
      var location = _matchLocation(result.headers["location"].toString());
      result = await _Dio.get(
        location,
        options: getOptions,
      );
      location = _matchLocation(result.headers["location"].toString());
      result = await _Dio.get(location, options: getOptions);
      String text = result.data.toString();
      String token = _matchToken(text);
      LocalStorage.save("token", token);
      LocalStorage.save("username", username);
      LocalStorage.save("password", password);
      return (true, token);
    } catch (e) {
      return (false, e.toString());
    }
  }

  Future<ClassTableModel?> getClassTable(String token, {String week = "1"}) async {
    var result = await _Dio.get(getServiceURL(Service.classtable, week: week),
        options: Options(headers: {
          "token": token,
        }));
    if (result.statusCode == 200) {
      var response = ClassTableModel.fromJson(result.data);
      DatabaseHelper.instance.clearClassTable();
      DatabaseHelper.instance.insertClassTable(response);
      return response;
    } else {
      return ClassTableModel();
    }
  }

  Future<ExamsModel> getExams(String token) async {
    var result = await _Dio.get(getServiceURL(Service.exams),
        options: Options(headers: {
          "token": token,
        }));
    if (result.statusCode == 200) {
      var response = ExamsModel.fromJson(result.data);
      DatabaseHelper.instance.clearExams();
      DatabaseHelper.instance.insertExams(response);
      return response;
    } else {
      return ExamsModel();
    }
  }

  Future<GradesModel> getGrades(String token) async {
    var result = await _Dio.get(getServiceURL(Service.grades),
        options: Options(headers: {
          "token": token,
        }));
    if (result.statusCode == 200) {
      var response = GradesModel.fromJson(result.data);
      DatabaseHelper.instance.clearGrade();
      DatabaseHelper.instance.insertGrade(response);
      return response;
    } else {
      return GradesModel();
    }
  }

  Future<SocialExamsModel> getSocialExams(String token) async {
    var result = await _Dio.get(getServiceURL(Service.socialExams),
        options: Options(headers: {
          "token": token,
        }));
    if (result.statusCode == 200) {
      var response = SocialExamsModel.fromJson(result.data);
      DatabaseHelper.instance.clearSocialExams();
      DatabaseHelper.instance.insertSocialExams(response);
      return response;
    } else {
      return SocialExamsModel();
    }
  }

  Future<UserInfoModel> getUserInfo(String token) async {
    var result = await _Dio.get(getServiceURL(Service.userinfo),
        options: Options(headers: {
          "token": token,
        }));
    if (result.statusCode == 200) {
      var response = UserInfoModel.fromJson(result.data);
      DatabaseHelper.instance.clearUser();
      DatabaseHelper.instance.insertUser(response);
      return response;
    } else {
      return UserInfoModel();
    }
  }

  Future<TermsModel> getTerms(String token) async {
    var result = await _Dio.get(getServiceURL(Service.terms),
        options: Options(headers: {
          "token": token,
        }));
    if (result.statusCode == 200) {
      return TermsModel.fromJson(result.data);
    } else {
      return TermsModel();
    }
  }

  void updateAll(String token) async {
    await getGrades(token);
    await getExams(token);
    await getSocialExams(token);
    await getUserInfo(token);
    await getTerms(token);
  }

  void initLocal() async {
    String? token = await LocalStorage.get("token");
    token = token ?? "";
    Global.token.value = token;
    String? username = await LocalStorage.get("username");
    username = username ?? "";
    Global.username.value = username;
    String? password = await LocalStorage.get("password");
    password = password ?? "";
    Global.password.value = password;
    if (username.isNotEmpty) {
      Global.isLogined.value = true;
    } else {
      Global.isLogined.value = false;
    }
  }
}

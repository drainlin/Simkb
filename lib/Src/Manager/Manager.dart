import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:simkb/Src/Manager/Encrypt.dart';
import 'package:cookie_jar/cookie_jar.dart';

final _Dio = Dio();

class Manager {
  Manager._() {
    (_Dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (url) {
        return "PROXY 192.168.10.114:8888";
      };
      //抓Https包设置
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };
  }
  final _loginURL =
      "https://cas.paas.cdut.edu.cn/cas/login?service=http%3A%2F%2Fmjw.cdut.edu.cn%2Fcdlgdxhd%2FloginSso&redirect_uri=http%3A%2F%2Fpaym-cdut-edu-cn.vpn.cdut.edu.cn%3A8118%2FcasLogin%2F";
  final _jwURL = "http://mjw.cdut.edu.cn/cdlgdxhd";

  final cookieJar = CookieJar();
  static final Manager _instance = Manager._();
  factory Manager() {
    return _instance;
  }

  String matchCookies(String cookie) {
    const cookiePattern = r'\[([^=]+)=([^;]+)';
    final matches = RegExp(cookiePattern).allMatches(cookie);

    final List<String> cookies = [];

    for (var match in matches) {
      final name = match.group(1);
      final value = match.group(2);
      cookies.add("$name=$value");
    }

    final formattedCookies = cookies.join('; ');
    return formattedCookies;
  }

  String matchLocation(String location) {
    if (location.isNotEmpty) {
      return location.substring(1, location.length - 1);
    } else {
      return "";
    }
  }

  String matchToken(String text) {
    const tokenPattern = "token=([^&']+)";
    final match = RegExp(tokenPattern).firstMatch(text);

    if (match != null) {
      final token = match.group(1);
      return token!;
    } else {
      print("No token found in the text.");
      return "";
    }
  }

  void getToken(String username, String password) async {
    await cookieJar.deleteAll();
    _Dio.interceptors.add(CookieManager(cookieJar));
    String rsaPassword = await Encrypt.encrypt(password);
    // 第一次 post
    var result = await _Dio.post(
      _loginURL,
      data: {
        "username": username,
        "password": rsaPassword,
        "captcha": "",
        "currentMenu": "1",
        "failN": "0",
        "execution": "e1s1",
        "_eventId": "submit",
        "geolocation": "",
        "submit": "稍等片刻……"
      },
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );

    // 第二次 get
    await _Dio.get(_loginURL, options: Options(followRedirects: false));

    /// 第三次 post
    result = await _Dio.post(
      _loginURL,
      data: {
        "username": username,
        "password": rsaPassword,
        "captcha": "",
        "currentMenu": "1",
        "failN": "0",
        "execution": "e1s1",
        "_eventId": "submit",
        "geolocation": "",
        "submit": "稍等片刻……"
      },
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    print(result.statusCode); //401 是密码错误
    var location = matchLocation(result.headers["location"].toString());

    /// 第四次 get
    result = await _Dio.get(
      location,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );

    /// 第五次 get
    location = matchLocation(result.headers["location"].toString());
    result = await _Dio.get(location,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));
    String text = result.data.toString();
    String token = matchToken(text);
    print(token);
  }
}

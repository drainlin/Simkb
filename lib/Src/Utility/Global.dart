import 'package:get/get.dart';

import '../Model/Response/UserInfoModel.dart';

class Global {
  static var termStart = DateTime(2023, 9, 4);
  static var token = "".obs;
  static var username = "".obs;
  static var password = "".obs;
  static var isLogined = false.obs;
  static var userInfo = UserInfoModel().obs;
  static var eventNames = <String>[].obs;
}

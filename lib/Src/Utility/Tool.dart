import 'package:flutter/foundation.dart';

class Tool {
  static void printLog(dynamic log) {
    if (kDebugMode) {
      print(log);
    }
  }
}

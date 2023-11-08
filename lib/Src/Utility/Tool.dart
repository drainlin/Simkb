import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:simkb/Src/Model/Local/ClassTableModel.dart';

class Tool {
  static void printLog(dynamic log) {
    if (kDebugMode) {
      print(log);
    }
  }

  static List<CalendarEventData> formatClassTableToEvents(List<ClassTableModel> lists) {
    var events = <CalendarEventData>[];
    for (var list in lists) {
      final date = DateTime.parse(list.date ?? "");
      final startTime = DateTime.parse("${list.date} ${list.startTime}");
      var endTime = DateTime.now();
      if (list.endTIme == null) {
        final length = list.coursesNote ?? 1;

        endTime = startTime.add(Duration(minutes: length > 1 ? length * 45 + (length - 1) * 10 : 45));
      } else {
        endTime = DateTime.parse("${list.date} ${list.endTIme}");
      }

      var event = CalendarEventData(date: date, event: list, startTime: startTime, endTime: endTime, title: "Event");
      events.add(event);
    }
    CalendarControllerProvider.of(Get.context!).controller.addAll(events);
    return events;
  }
}

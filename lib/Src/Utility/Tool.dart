import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simkb/Src/Model/Local/ClassTableModel.dart';
import 'package:simkb/Src/Utility/Global.dart';

class Tool {
  static void printLog(dynamic log) {
    if (kDebugMode) {
      print(log);
    }
  }

  static List<CalendarEventData> formatClassTableToEvents(
      List<ClassTableModel> lists) {
    var events = <CalendarEventData>[];
    var eventsName = <String>[];
    for (var list in lists) {
      if (!eventsName.contains(list.courseName)) {
        eventsName.add(list.courseName ?? "");
      }
      final date = DateTime.parse(list.date ?? "");
      final startTime = DateTime.parse("${list.date} ${list.startTime}");
      var endTime = DateTime.now();
      if (list.endTIme == null) {
        final length = list.coursesNote ?? 1;

        endTime = startTime.add(Duration(
            minutes: length > 1 ? length * 45 + (length - 1) * 10 : 45));
      } else {
        endTime = DateTime.parse("${list.date} ${list.endTIme}");
      }

      var event = CalendarEventData(
          date: date,
          event: list,
          startTime: startTime,
          endTime: endTime,
          title: "Event");
      events.add(event);
    }
    Global.eventNames.value = eventsName;
    CalendarControllerProvider.of(Get.context!).controller.addAll(events);
    return events;
  }

  static var colorStyle = [
    Colors.amber,
    Colors.blue,
    Colors.brown,
    Colors.pink,
    Colors.purple,
    Colors.green,
    Colors.grey,
    Colors.orange,
    Colors.teal,
    Colors.cyan,
    Colors.indigo,
    Colors.amber,
    Colors.blue,
    Colors.brown,
    Colors.pink,
    Colors.purple,
    Colors.green,
    Colors.grey,
    Colors.orange,
    Colors.teal,
    Colors.cyan,
    Colors.indigo
  ];
  static colorIndex(List<String> list, String name) {
    var set = [];
    for (var item in list) {
      if (!set.contains(item)) {
        set.add(item);
      }
    }
    var i = set.indexOf(name);
    if (i == -1) {
      return colorStyle[0];
    }
    return colorStyle[i];
  }
}

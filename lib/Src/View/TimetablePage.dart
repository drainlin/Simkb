import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:simkb/Src/Model/Database.dart';
import 'package:simkb/Src/Utility/Tool.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getClassTable().then((value) {
      Tool.formatClassTableToEvents(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WeekView(
      minDay: DateTime.now().subtract(const Duration(days: 180)),
      maxDay: DateTime.now().add(const Duration(days: 180)),
      initialDay: DateTime.now(),
      eventTileBuilder: (date, events, boundary, startDuration, endDuration) {
        return _buildEvent(events);
      },
    );
  }

  Widget _buildEvent(List<CalendarEventData<Object?>> events) {
    return Container(
      decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: events.isEmpty
          ? Container()
          : Column(
              children: [
                Text(events.first.title),
              ],
            ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simkb/Src/Model/Database.dart';
import 'package:simkb/Src/Utility/Global.dart';
import 'package:simkb/Src/Utility/Tool.dart';

import '../Model/Local/ClassTableModel.dart';
import '../Model/Mod/TableWeekView.dart';

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
    return TableWeekView(
      minDay: Global.termStart,
      scrollOffset: 450,
      safeAreaOption: const SafeAreaOption(bottom: false),
      maxDay: Global.termStart.add(const Duration(days: 7 * 20 - 1)),
      initialDay: DateTime.now(),
      weekTitleHeight: 70,
      eventTileBuilder: (date, events, boundary, startDuration, endDuration) {
        return _buildEvent(events, boundary);
      },
    );
  }

  Widget _buildEvent(List<CalendarEventData<Object?>> events, Rect boundary) {
    if (events.isEmpty) return Container();
    ClassTableModel event = events.first.event as ClassTableModel;
    return GestureDetector(
      onTap: () {
        _showDetail(event);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Tool.colorIndex(Global.eventNames, event.courseName ?? ""),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            AutoSizeText(
              event.courseName ?? "",
              style: const TextStyle(color: Colors.white),
              maxLines: boundary.height < 50 ? 1 : 4,
              minFontSize: 8,
              maxFontSize: 11,
            ),
            SizedBox(
              height: boundary.height < 50 ? 5 : 10,
            ),
            AutoSizeText(
              event.classroomName ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              maxLines: boundary.height < 100 ? 1 : 2,
              minFontSize: 8,
              maxFontSize: 10,
            ),
          ],
        ).paddingAll(5),
      ),
    );
  }

  void _showDetail(ClassTableModel event) {
    Widget _buildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
    ) {
      return Material(
        child: ListView(
          controller: scrollController,
          shrinkWrap: true,
          children: [
            CourseDetail(course: event),
          ],
        ),
      );
    }

    showFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.8,
      maxHeight: 0.8,
      context: context,
      builder: _buildBottomSheet,
      isExpand: false,
    );
  }
}

class CourseDetail extends StatelessWidget {
  final ClassTableModel course;
  const CourseDetail({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              course.courseName ?? "未知",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ).paddingOnly(top: 20, bottom: 10))
          ],
        ),
        Row(
          children: [
            Image.asset(
              'images/time.png',
              height: 35,
              width: 35,
            ).paddingOnly(right: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "时间:",
                  style: TextStyle(color: Colors.grey),
                ),
                Text("${course.date}  ${course.startTime} ~ ${course.endTIme}")
              ],
            )
          ],
        ).paddingOnly(top: 20, bottom: 10),
        Row(
          children: [
            Image.asset(
              'images/location.png',
              height: 35,
              width: 35,
            ).paddingOnly(right: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "地点:",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(course.classroomName ?? "无")
              ],
            )
          ],
        ).paddingOnly(top: 20, bottom: 10),
        Row(
          children: [
            Image.asset(
              'images/teacher.png',
              height: 35,
              width: 35,
            ).paddingOnly(right: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.teacherName == null ? "备注:" : "教师：",
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(course.teacherName ?? "无")
              ],
            )
          ],
        ).paddingOnly(top: 20, bottom: 10)
      ],
    ).paddingOnly(left: 20, bottom: 20, right: 20);
  }
}

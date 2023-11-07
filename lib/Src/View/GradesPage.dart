import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simkb/Src/Model/Database.dart';
import 'package:simkb/Src/Model/Local/GradeModel.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  var grades = [].obs;
  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getGrades().then((value) {
      grades.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的成绩'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (grades.isNotEmpty) {
        return ListView.builder(
          itemCount: grades.length,
          itemBuilder: (context, index) {
            GradeModel grade = grades[index];
            return ListTile(
              title: Text(grade.courseName ?? ""),
              subtitle:
                  Text("${grade.courseNature} ${grade.examinationNature}"),
              trailing: Text(
                grade.fraction ?? "?",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
        );
      } else {
        return const Center(
          child: Text("暂无数据"),
        );
      }
    });
  }
}

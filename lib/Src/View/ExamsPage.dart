import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simkb/Src/Model/Database.dart';
import 'package:simkb/Src/Model/Local/ExamModel.dart';

class ExamsPage extends StatefulWidget {
  const ExamsPage({super.key});

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  var exams = [].obs;
  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getExams().then((value) {
      exams.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的考试'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (exams.isNotEmpty) {
        return ListView.builder(
          itemCount: exams.length,
          itemBuilder: (context, index) {
            ExamModel exam = exams[index];
            return ListTile(
              title: Text(exam.courseName ?? ""),
              subtitle: Text(exam.examinationPlace ?? ""),
              trailing: Text(
                (exam.time ?? "?").replaceAll(" ", "\n"),
                textAlign: TextAlign.center,
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

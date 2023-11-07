import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simkb/Src/Model/Database.dart';
import 'package:simkb/Src/Model/Local/SocialExamModel.dart';

class SocialExamsPage extends StatefulWidget {
  const SocialExamsPage({super.key});

  @override
  State<SocialExamsPage> createState() => _SocialExamsPageState();
}

class _SocialExamsPageState extends State<SocialExamsPage> {
  var socialExams = [].obs;
  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getSocialExams().then((value) {
      socialExams.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('等级考试成绩'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (socialExams.isNotEmpty) {
        return ListView.builder(
          itemCount: socialExams.length,
          itemBuilder: (context, index) {
            SocialExamModel socialExam = socialExams[index];
            return ListTile(
              title: Text(socialExam.courseName ?? ""),
              subtitle: Text("${socialExam.socialExaminationGradeName}"),
              trailing: Text(
                socialExam.overallResult ?? "?",
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

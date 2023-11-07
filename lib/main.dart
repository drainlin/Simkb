import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simkb/Src/Model/Local/SocialExamModel.dart';
import 'package:simkb/Src/Model/Manager.dart';
import 'package:simkb/Src/Utility/Global.dart';
import 'package:simkb/Src/Utility/Tool.dart';
import 'package:simkb/Src/View/ExamsPage.dart';
import 'package:simkb/Src/View/SocialExamsPage.dart';
import 'package:simkb/Src/View/UserInfoPage.dart';

import 'Src/View/GradesPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    Manager().initLocal();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;

      Manager().getToken("202202070102", "Qs961314..0*5").then((value) {
        if (value.$1) {
          Global.token.value = value.$2;
          Tool.printLog(Global.token.value);
        } else {
          Tool.printLog(value.$2);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => Text(Global.token.value)),
            ElevatedButton(
                onPressed: () {
                  Manager().updateAll(Global.token.value);
                },
                child: const Text("全部刷新")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const ExamsPage());
                },
                child: const Text("前往Exams")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const SocialExamsPage());
                },
                child: const Text("前往SocialExams")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const GradesPage());
                },
                child: const Text("前往Grades")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const UserInfoPage());
                },
                child: const Text("前往MYpage")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

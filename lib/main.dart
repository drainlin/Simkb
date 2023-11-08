import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:simkb/Src/Model/Manager.dart';
import 'package:simkb/Src/Utility/Global.dart';
import 'package:simkb/Src/Utility/Tool.dart';
import 'package:simkb/Src/View/ExamsPage.dart';
import 'package:simkb/Src/View/LoginPage.dart';
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
      title: 'Sim课表',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sim课表'),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
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
  @override
  void initState() {
    super.initState();
    Manager().initLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: _buildDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => Text(Global.token.value)),
            ElevatedButton(
                onPressed: () {
                  Manager().getToken("202202070102", "Qs961314..0*5").then((value) {
                    if (value.$1) {
                      Global.token.value = value.$2;
                      Tool.printLog(Global.token.value);
                    } else {
                      Tool.printLog(value.$2);
                    }
                  });
                },
                child: const Text("登陆")),
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
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: _buildDrawerHeaderWidget(),
          ),
          ListTile(
            title: const Text('课表'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('成绩'),
            onTap: () {
              Get.to(() => const GradesPage());
            },
          ),
          ListTile(
            title: const Text('考试'),
            onTap: () {
              Get.to(() => const ExamsPage());
            },
          ),
          ListTile(
            title: const Text('等级考试'),
            onTap: () {
              Get.to(() => const SocialExamsPage());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeaderWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '欢迎使用Sim课表',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              Get.to(() => const LoginPage());
            },
            child: const Text("获取数据",
                style: TextStyle(
                  fontSize: 20,
                )))
      ],
    );
  }
}

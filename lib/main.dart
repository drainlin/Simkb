import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:simkb/Src/Model/Manager.dart';
import 'package:simkb/Src/Utility/Global.dart';
import 'package:simkb/Src/Utility/Tool.dart';
import 'package:simkb/Src/View/ExamsPage.dart';
import 'package:simkb/Src/View/LoginPage.dart';
import 'package:simkb/Src/View/SocialExamsPage.dart';
import 'package:simkb/Src/View/TimetablePage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'Src/View/GradesPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController(),
        child: GetMaterialApp(
          title: 'Sim课表',
          locale: const Locale('zh', 'CN'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh', 'CN'), // 中文
            Locale('en', 'US'), // English
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Sim课表'),
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var version = "expired";
  @override
  void initState() {
    super.initState();
    Manager().initLocal();
    Tool.getAppVersion().then((value) {
      setState(() {
        version = value;
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
      drawer: _buildDrawer(),
      body: const TimetablePage(),
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
          ListTile(
            title: const Text('获取数据'),
            onTap: () {
              Get.to(() => const LoginPage());
            },
          ),
          ListTile(
            title: Text(version),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("关于"),
                        content: const Text(
                            "本软件仅供学习交流使用\n不得用于商业用途\n本软件不会收集任何用户信息\n请自行负责数据安全\n如果喜欢请在GitHub上为我点亮星星"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                                launchUrlString(
                                    "https://github.com/drainlin/Simkb");
                              },
                              child: const Text("GitHub")),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("关闭"))
                        ],
                      ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeaderWidget() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'images/AppIcon.png',
                    height: 60,
                    width: 60,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Sim课表",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            if (!Global.isLogined.value)
              Row(
                children: [
                  Text(
                    '欢迎你，新同学',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            if (!Global.isLogined.value)
              Row(
                children: [
                  Text(
                    '首次使用请先获取数据',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            if (Global.isLogined.value)
              Row(
                children: [
                  Text(
                    '${_welcome()}~',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            if (Global.isLogined.value)
              Row(
                children: [
                  Text(
                    '当前用户：${Global.userInfo.value.name ?? ''}同学',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                    ),
                  )
                ],
              )
          ],
        ));
  }

  String _welcome() {
    if (DateTime.now().hour < 6) {
      return "夜深了";
    } else if (DateTime.now().hour < 9) {
      return "早上好";
    } else if (DateTime.now().hour < 12) {
      return "上午好";
    } else if (DateTime.now().hour < 14) {
      return "中午好";
    } else if (DateTime.now().hour < 17) {
      return "下午好";
    } else if (DateTime.now().hour < 19) {
      return "傍晚好";
    } else if (DateTime.now().hour < 22) {
      return "晚上好";
    } else {
      return "夜深了";
    }
  }
}

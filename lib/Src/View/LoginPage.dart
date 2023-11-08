import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:simkb/Src/Model/Localstorage.dart';

import '../Model/Manager.dart';
import '../Utility/Global.dart';
import '../Utility/Tool.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // var _username = "202202070102";
  // var _password = "Qs961314..0*5";
  var _username = "";
  var _password = "";
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    LocalStorage.get("username").then((value) {
      if (value != null) {
        _username = value;
        _usernameController.text = value;
      }
    });
    LocalStorage.get("password").then((value) {
      if (value != null) {
        _password = value;
        _passwordController.text = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("砚湖易办"),
        ),
        body: Column(
          children: [
            TextField(
                decoration: const InputDecoration(
                  labelText: "学号",
                ),
                onChanged: (value) => _username = value,
                controller: _usernameController,
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp("^[a-z0-9A-Z]+"), allow: true), //只允许输入数字，字母
                ]),
            TextField(
              decoration: const InputDecoration(
                labelText: "密码",
              ),
              onChanged: (value) => _password = value,
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _goLogin();
              },
              child: const Text("马上获取"),
            )
          ],
        ).paddingAll(15));
  }

  void _goLogin() async {
    if (_username.isEmpty || _password.isEmpty) {
      SmartDialog.showToast("学号或密码不能为空", alignment: Alignment.center);
      return;
    }
    SmartDialog.showLoading(msg: "正在更新数据");
    await Manager().getToken(_username, _password).then((value) async {
      if (value.$1) {
        Global.token.value = value.$2;
        Tool.printLog(Global.token.value);
        Manager().updateAll(Global.token.value);
        SmartDialog.dismiss();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("成功"),
                  content: const Text("可以查看数据了"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("确定"))
                  ],
                ));
      } else {
        Tool.printLog(value.$2);
        SmartDialog.dismiss();
        SmartDialog.showToast(value.$2, alignment: Alignment.center);
      }
    });
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simkb/Src/Model/Manager.dart';
import 'package:simkb/Src/Model/Response/UserInfoModel.dart';
import 'package:simkb/Src/Utility/Global.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  UserInfoModel? userInfo;
  @override
  void initState() {
    super.initState();
    Manager().getUserInfo(Global.token.value).then((value) {
      setState(() {
        userInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("个人信息")),
      body: Center(
        child: userInfo != null
            ? Column(
                children: [
                  Text(userInfo!.name ?? ""),
                  Text(userInfo!.academyName ?? ""),
                  Text(userInfo!.userNo ?? ""),
                  Text(userInfo!.birthday ?? ""),
                  Text(userInfo!.entranceYear ?? "")
                ],
              )
            : const Text("暂无数据"),
      ),
    );
  }
}

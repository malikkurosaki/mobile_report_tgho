import 'package:easy_web_view2/easy_web_view2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_report/tgho/tg_config.dart';

class TgPageWebView extends StatelessWidget {
  const TgPageWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: EasyWebView(
            webAllowFullScreen: true,
            src: TgConfig.baseUrlWeb,
            onLoaded: () {
              EasyLoading.showToast("page loaded");
            },
          )),
    );
  }
}

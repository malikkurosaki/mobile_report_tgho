import 'package:easy_web_view2/easy_web_view2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TgPageWebView extends StatelessWidget {
  const TgPageWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
            child: EasyWebView(
              webAllowFullScreen: true,
              src: "https://malikkurosaki.github.io/mobile_report_tgho/client/build/web/#/dashboard",
              onLoaded: () {
                EasyLoading.showToast("page loaded");
              },
            ),
          ),
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_report/Val.dart';
import 'package:mobile_report/app/home.dart';
import 'package:mobile_report/app/v2_home.dart';
import 'package:mobile_report/intro.dart';
import 'package:mobile_report/login.dart';
import 'package:mobile_report/v2_intro.dart';
import 'package:mobile_report/v2_val.dart';

import 'pref.dart';
import 'v2_pref.dart';

class V2Splash extends StatefulWidget {
  const V2Splash({Key? key}) : super(key: key);

  @override
  State<V2Splash> createState() => _V2SplashState();
}

class _V2SplashState extends State<V2Splash> {

  @override
  void initState() {
    onLoad();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/splash3.png'),
          ),
        ),
        child: Stack(
          children: [
            // Container(
            //   width: double.infinity,
            //   height: double.infinity,
            //   color: Colors.black38,
            // ),
            Center(
              child: Text(
                "MOBILE\rREPORT",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.grey[900]),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 0,
              left: 0,
              child: Center(
                child: Text("by Probus System"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onLoad() async {

    await 3.delay();
    if (V2Pref.isIntro().get()??true) {
      Get.offAll(V2Intro());
      return;
    }

    if (V2Pref.user().get() == null) {
      Get.offAll(Login());
      return;
    }

    Get.offAll(V2Home());
  }
}

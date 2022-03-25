import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_report/Val.dart';
import 'package:mobile_report/models.dart';
import 'package:mobile_report/tgho/tg_router.dart';
import 'package:mobile_report/tgho/tg_util_load.dart';
import 'package:mobile_report/v2_router.dart';
import 'package:mobile_report/splash.dart';
import 'package:mobile_report/v2_models.dart';
import 'package:mobile_report/v2_pref.dart';
import 'package:mobile_report/v2_splash.dart';
import 'package:mobile_report/v2_val.dart';

void main() async {
  await GetStorage.init();
  TgUtilLoad().loadFirst();

  // deprecated [akan dihapus karena kemungkinan tidak digunakan]
  // Val.config = ModelConfig.fromJson(
  //     jsonDecode(await rootBundle.loadString('config.json')));

  // V2Val.config.value = V2ModelConfig.fromJson(jsonDecode(await rootBundle.loadString('v2_config.json')));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Report',
      initialRoute: '/',
      getPages: TgRouter.pages,
      builder: EasyLoading.init(),
    );
  }
}

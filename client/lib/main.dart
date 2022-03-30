import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_report/tgho/tg_util_load.dart';
import 'package:mobile_report/tgho/tg_util_router.dart';
import 'package:mobile_report/tgho/tg_page_web_view.dart';

void main() async {

  if(GetPlatform.isAndroid){
    runApp(MyAppWbView());
    return;
  }

  await GetStorage.init();
  try {
    TgUtilLoad().loadFirst();
  } catch (e) {
    print(e);
  }
  runApp(const MyApp());
}


class MyAppWbView extends StatelessWidget {
  const MyAppWbView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: TgPageWebView(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Mobile Report',
      initialRoute: '/',
      getPages: TgUtilRouter.pages,
      builder: EasyLoading.init(),
    );
  }
}

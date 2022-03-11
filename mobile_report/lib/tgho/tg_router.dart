import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:mobile_report/app/v2_dashboard_option.dart';
import 'package:mobile_report/app/v2_home.dart';
import 'package:mobile_report/app/v2_profile.dart';
import 'package:mobile_report/intro.dart';
import 'package:mobile_report/login.dart';
import 'package:mobile_report/tgho/tg_develop.dart';
import 'package:mobile_report/v2_root.dart';

import 'tg_dashboard.dart';
import 'tg_product_report.dart';

class TgRouter{
  late String key;
  TgRouter.root() : key = '/';
  TgRouter.developer(): key = "/developer";
  TgRouter.home() : key = '/home';
  TgRouter.login() : key = '/login';
  TgRouter.register() : key = '/register';
  TgRouter.intro() : key = '/intro';
  TgRouter.dashboardOptions() : key = '/dashboardOptions';
  TgRouter.profile() : key = '/profile';
  TgRouter.dashboard() : key = '/dashboard';
  TgRouter.productReport() : key = '/productReport';

  go() => Get.toNamed(key);
  goOff() => Get.offNamed(key);
  goOffAll() => Get.offAllNamed(key);

  static final pages = <GetPage>[
    GetPage(name: TgRouter.developer().key, page: () => TgDevelop()),
    GetPage(name: TgRouter.root().key, page: () => V2Root()),
    GetPage(name: TgRouter.home().key, page: () => V2Home()),
    GetPage(name: TgRouter.login().key, page: () => Login()),
    GetPage(name: TgRouter.intro().key, page: () => Intro()),
    GetPage(name: TgRouter.dashboardOptions().key, page: () => V2DashboardOption(),),
    GetPage(name: TgRouter.profile().key, page: () => V2Profile(),),
    GetPage(name: TgRouter.dashboard().key, page: () => TgDashboard()),
    GetPage(name: TgRouter.productReport().key, page: () => TgProductReport()),
  ];
  
}
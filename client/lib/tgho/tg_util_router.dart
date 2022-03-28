import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:mobile_report/app/v2_dashboard_option.dart';
import 'package:mobile_report/app/v2_home.dart';
import 'package:mobile_report/app/v2_profile.dart';
import 'package:mobile_report/intro.dart';
import 'package:mobile_report/login.dart';
import 'package:mobile_report/tgho/tg_develop.dart';
import 'package:mobile_report/tgho/tg_page_login.dart';
import 'package:mobile_report/tgho/tg_page_intro.dart';
import 'package:mobile_report/v2_root.dart';

import 'tg_page_dashboard.dart';
import 'tg_dept_report.dart';
import 'tg_performance.dart';
import 'tg_product_report.dart';
import 'tg_root.dart';
import 'tg_page_wellcome.dart';

class TgUtilRouter{
  late String key;
  TgUtilRouter.root() : key = '/';
  TgUtilRouter.developer(): key = "/developer";
  TgUtilRouter.home() : key = '/home';
  TgUtilRouter.login() : key = '/login';
  TgUtilRouter.register() : key = '/register';
  TgUtilRouter.intro() : key = '/intro';
  TgUtilRouter.dashboardOptions() : key = '/dashboardOptions';
  TgUtilRouter.profile() : key = '/profile';
  TgUtilRouter.dashboard() : key = '/dashboard';
  TgUtilRouter.productReport() : key = '/productReport';
  // wellcome
  TgUtilRouter.wellcome() : key = '/wellcome';
  // performance report
  TgUtilRouter.performanceReport() : key = '/performanceReport';
  // dept report
  TgUtilRouter.deptReport() : key = '/deptReport';
  

  go() => Get.toNamed(key);
  goOff() => Get.offNamed(key);
  goOffAll() => Get.offAllNamed(key);

  static final pages = <GetPage>[
    GetPage(name: TgUtilRouter.developer().key, page: () => TgDevelop()),
    GetPage(name: TgUtilRouter.root().key, page: () => TgRoot()),
    // GetPage(name: TgUtilRouter.home().key, page: () => V2Home()),
    // GetPage(name: TgRouter.login().key, page: () => Login()),
    GetPage(name: TgUtilRouter.intro().key, page: () => TgPageIntro()),
    // GetPage(name: TgUtilRouter.dashboardOptions().key, page: () => V2DashboardOption(),),
    // GetPage(name: TgUtilRouter.profile().key, page: () => V2Profile(),),
    GetPage(name: TgUtilRouter.dashboard().key, page: () => TgPageDashboard()),
    GetPage(name: TgUtilRouter.productReport().key, page: () => TgProductReport()),
    // performance report
    GetPage(name: TgUtilRouter.performanceReport().key, page: () => TgPerformanceReport()),
    // dept report
    GetPage(name: TgUtilRouter.deptReport().key, page: () => TgDeptReport()),
    // wellcome
    GetPage(name: TgUtilRouter.wellcome().key, page: () => TgPageWellcome()),
    // login
    GetPage(name: TgUtilRouter.login().key, page: () => TgPageLogin()),
  ];
  
}
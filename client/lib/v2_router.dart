// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:mobile_report/app/dashboard.dart';
// import 'package:mobile_report/app/home.dart';
// import 'package:mobile_report/app/v2_dashboard_option.dart';
// import 'package:mobile_report/app/v2_home.dart';
// import 'package:mobile_report/app/v2_profile.dart';
// import 'package:mobile_report/intro.dart';
// import 'package:mobile_report/login.dart';
// import 'package:mobile_report/tgho/tg_dashboard.dart';
// import 'package:mobile_report/v2_config.dart';
// import 'package:mobile_report/v2_root.dart';


// class V2Router {
//   late String _key;

//   V2Router.home() : _key = '/home';
//   V2Router.login() : _key = '/login';
//   V2Router.register() : _key = '/register';
//   V2Router.root() : _key = '/';
//   V2Router.intro() : _key = '/intro';
//   V2Router.dashboardOptions() : _key = '/dashboardOptions';
//   V2Router.profile() : _key = '/profile';
//   V2Router.dashboard() : _key = '/dashboard';

//   // String get key => _key;
//   set key(String value) => _key = value;

//   go() {
//     Get.toNamed(_key);
//   }

//   goOff() {
//     Get.offNamed(_key);
//   }

//   static final listPage = [
//     GetPage(name: V2Router.root()._key, page: () => V2Root()),
//     GetPage(name: V2Router.home()._key, page: () => V2Home()),
//     GetPage(name: V2Router.login()._key, page: () => Login()),
//     GetPage(name: V2Router.intro()._key, page: () => Intro()),
//     GetPage(name: V2Router.dashboardOptions()._key, page: () => V2DashboardOption(),),
//     GetPage(name: V2Router.profile()._key, page: () => V2Profile(),),
//     GetPage(name: V2Router.dashboard()._key, page: () => TgDashboard())
//   ];
// }

// import 'package:get/get_connect.dart';
// import 'package:mobile_report/Val.dart';
// import 'package:mobile_report/v2_config.dart';
// import 'package:mobile_report/v2_models.dart';
// import 'package:mobile_report/v2_pref.dart';
// import 'package:mobile_report/v2_val.dart';

// import 'config.dart';

// class V2Conn extends GetConnect{
//   // final url = Ambil<V2ModelConfig>().data(V2Pref.config().get()).dev!? Ambil<V2ModelConfig>().data(V2Pref.config().get()).urlDev: Ambil<V2ModelConfig>().data(V2Pref.config().get()).url;
//   // final url = V2Val.config.value.dev!? V2Val.config.value.urlDev: V2Val.config.value.url;
//   getPropertyDashBoard(String title) => '$title?tgl1=${V2Val.tanggal1.value}&tgl2=${V2Val.tanggal2.value}&out=${V2Val.out.value.kodeOut}&dep=${V2Val.dep.value.namaDept}&query=true';

//   Future<Response> getFood() => get(V2Config.url+'/'+getPropertyDashBoard("food"));
//   Future<Response> beverage() => get(V2Config.url+'/'+getPropertyDashBoard("beverage"));
//   Future<Response> other() => get(V2Config.url+'/'+getPropertyDashBoard("other"));

//   Future<Response> top10Food() => get(V2Config.url+'/'+getPropertyDashBoard("top10Food"));
//   Future<Response> top10Beverage() => get(V2Config.url+'/'+getPropertyDashBoard("top10Beverage"));
//   Future<Response> top10Other() => get(V2Config.url+'/'+getPropertyDashBoard("top10Other"));

//   Future<Response> masterDep() => get(V2Config.url+'/masterDep');
//   Future<Response> masterOut() => get(V2Config.url+'/masterOut');
//   Future<Response> listUser() => get(V2Config.url+'/listUser');

//   Future<Response> login(Map<String, dynamic> body) => post(V2Config.url+'/login', body);
//   Future<Response> totalRevenue() => get(V2Config.url+'/'+getPropertyDashBoard("totalRevenue"));

//   Future<Response> salesPerformanceWeek() => get(V2Config.url+'/salesPerformanceWeek?date='+V2Val.tanggal1.toString());
//   Future<Response> salesPerformanceMonth() => get(V2Config.url+'/salesPerformanceMonth?date='+V2Val.tanggal1.toString());

//   Future<Response> register(Map<String, dynamic> body) => post(V2Config.url+'/register', body);


// }
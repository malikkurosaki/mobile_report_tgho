import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:mobile_report/tgho/tg_config.dart';

import 'tg_util_val.dart';

class TgConn extends GetConnect {
  // dashboar report
  Future<Response> getDashboard(String tgl1, String tgl2, String dept, String out) =>
      get(TgConfig.baseUrl + "/dashboard?tgl1=$tgl1&tgl2=$tgl2&dept=$dept&out=$out");

  // year report
  Future<Response> getYearReport() => get(TgConfig.baseUrl + "/yearreport");

  // dept report
  Future<Response> getDeptReport() => get(TgConfig.baseUrl + "/deptReport");

  // product year report
  Future<Response> getProductReportYear() => get(TgConfig.baseUrl + "/productReportYear");

  // product mont report
  Future<Response> getProductReportMonth() => get(TgConfig.baseUrl + "/productReportMonth");

  // product week report
  Future<Response> getProductReportWeek() => get(TgConfig.baseUrl + "/productReportWeek");

  // product day report
  Future<Response> getProductReportToday() => get(TgConfig.baseUrl + "/productReportToday");

  // product report
  Future<Response> getRevenue() => get(TgConfig.baseUrl + "/revenue");

  // login
  Future<Response> login(Map body) => post(TgConfig.baseUrl + '/login', body);

  // ping
  Future<Response> ping() async {
    final ping = await get(TgConfig.baseUrl + '/ping');
    try {
      if (ping.body['success'].toString() == "true") {
        TgUtilVal.ping.value = false;
      }
    } catch (e) {
      TgUtilVal.ping.value = true;
    }

    return ping;
  }
}

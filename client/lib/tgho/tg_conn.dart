import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:mobile_report/tgho/tg_config.dart';

class TgConn extends GetConnect{
  // dashboar report
  Future<Response> getDashboard(String tgl1, String tgl2, String dept, String out) => get(Conf.baseUrl+"/dashboard?tgl1=$tgl1&tgl2=$tgl2&dept=$dept&out=$out");

  // year report
  Future<Response> getYearReport() => get(Conf.baseUrl+"/yearreport");

  // dept report
  Future<Response> getDeptReport() => get(Conf.baseUrl+"/deptReport");

  // product year report
  Future<Response> getProductReportYear() => get(Conf.baseUrl+"/productReportYear");

  // product mont report
  Future<Response> getProductReportMonth() => get(Conf.baseUrl+"/productReportMonth");

  // product week report
  Future<Response> getProductReportWeek() => get(Conf.baseUrl+"/productReportWeek");

  // product day report
  Future<Response> getProductReportToday() => get(Conf.baseUrl+"/productReportToday");

  // product report
  Future<Response> getRevenue() => get(Conf.baseUrl+"/revenue");

  // login
  Future<Response> login(Map body) => post(Conf.baseUrl+'/login', body);

}
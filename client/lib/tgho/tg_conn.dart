import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:mobile_report/conf.dart';

class TgConn extends GetConnect{
  // dashboar report
  Future<Response> getDashboard(String tgl1, String tgl2, String dept, String out) => get(Conf.url+"/dashboard?tgl1=$tgl1&tgl2=$tgl2&dept=$dept&out=$out");

  // year report
  Future<Response> getYearReport() => get(Conf.url+"/yearreport");

  // dept report
  Future<Response> getDeptReport() => get(Conf.url+"/deptReport");

  // product year report
  Future<Response> getProductReportYear() => get(Conf.url+"/productReportYear");

  // product mont report
  Future<Response> getProductReportMonth() => get(Conf.url+"/productReportMonth");

  // product week report
  Future<Response> getProductReportWeek() => get(Conf.url+"/productReportWeek");

  // product day report
  Future<Response> getProductReportToday() => get(Conf.url+"/productReportToday");

  // product report
  Future<Response> getRevenue() => get(Conf.url+"/revenue");

  // login
  Future<Response> login(Map body) => post(Conf.url+'/login', body);

}
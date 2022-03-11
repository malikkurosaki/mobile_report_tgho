import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:mobile_report/conf.dart';

class TgConn extends GetConnect{
  
  Future<Response> getDashboard(String tgl1, String tgl2, String dept, String out) => get(Conf.url+"/dashboard?tgl1=$tgl1&tgl2=$tgl2&dept=$dept&out=$out");
  Future<Response> getYearReport() => get(Conf.url+"/yearreport");
  Future<Response> getDeptReport() => get(Conf.url+"/deptReport");
  Future<Response> getProductReportYear() => get(Conf.url+"/productReportYear");
}
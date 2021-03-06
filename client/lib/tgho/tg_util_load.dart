import 'package:flutter/material.dart';
import 'package:mobile_report/pref.dart';
import 'package:mobile_report/tgho/tg_conn.dart';
import 'package:get/get.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';
import 'tg_util_val.dart';

class TgUtilLoad {
  TgUtilLoad();

  // dashboard
  dashboard() async {
    // get data from server
    final data = await TgConn().getDashboard("2022-02-10", "2022-03-01", "all", "all");

    try {
      if (data.body['success'].toString() == "true") {
        // dashboard
        // TgPref.dashboard(value: data.body['data']['data']??{});

        // master
        TgUtilPref.master(value: data.body['data']['master'] ?? {});

        // dashboard report
        // TgPref.dashboardReport(value: data.body['data']['report'] ?? {});

        // report
        TgUtilPref.report(value: data.body['data']['report'] ?? {});
        // by group
        TgUtilPref.reportByGroup(value: data.body['data']['report']['byGroup'] ?? []);
        // by outlet
        TgUtilPref.reportByOut(value: data.body['data']['report']['byOut'] ?? []);
        // by dept
        TgUtilPref.reportByDept(value: data.body['data']['report']['byDept'] ?? []);
        // by total
        TgUtilPref.reportByTotal(value: data.body['data']['report']['byTotal'] ?? {});
      }
    } catch (e) {
      print(e.toString());
    }
    print("==>load dasboard");
  }

  // product year
  productYear() async {
    final year = await TgConn().getProductReportYear();
    if (year.body['success'].toString() == "true") {
      TgUtilPref.productYearReport(value: year.body['data']);
    }
    print("==> load product year");
  }

  // product month
  productMonth() async {
    TgUtilPref.productMonthReport();
    final month = await TgConn().getProductReportMonth();
    if (month.body['success'].toString() == "true") {
      TgUtilPref.productMonthReport(value: month.body['data']);
    }
    print("==> load product month");
  }

  // product week
  productWeek() async {
    TgUtilPref.productWeekReport();
    final week = await TgConn().getProductReportWeek();
    if (week.body['success'].toString() == "true") {
      TgUtilPref.productWeekReport(value: week.body['data']);
    }
    print("==> load product week");
  }

  // product day
  productDay() async {
    TgUtilPref.productDayReport();
    final today = await TgConn().getProductReportToday();
    if (today.body['success'].toString() == "true") {
      TgUtilPref.productDayReport(value: today.body['data']);
    }
    print("==> load product today");
  }

  // year report
  yearReport() async {
    final year = await TgConn().getYearReport();
    if (year.body['success'].toString() == "true") {
      TgUtilPref.yearReport(value: year.body['data']);
    }

    print("==> load year report");
  }

  // dept report
  deptReport() async {
    final dept = await TgConn().getDeptReport();
    if (dept.body['success'].toString() == "true") {
      TgUtilPref.deptReport(value: dept.body['data']);
    }

    print("==> load dept report");
  }

  Widget ping() => Obx(
        () => TgUtilVal.ping.value? FutureBuilder<Response>(
          future: TgConn().ping(),
          builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
              ? Center(
                  child: Text("load new data ... ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                )
              : Visibility(
                  visible: snapshot.connectionState == ConnectionState.done,
                  child: Center(
                    child: snapshot.data!.body.toString() != "true"
                        ? Text(
                            "Server Timeout ...",
                            style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        : SizedBox.shrink(),
                  ),
                ),
        ): SizedBox.shrink(),
      );
}

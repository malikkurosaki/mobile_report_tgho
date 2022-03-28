import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mobile_report/tgho/tg_util_load.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';
import 'package:mobile_report/tgho/tg_util_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'tg_sub_best_product.dart';
import 'tg_sub_product_year.dart';
import 'tg_sub_revenue_by_departement.dart';
import 'tg_sub_total_revenue_by_group.dart';
import 'tg_sub_year_to_day.dart';

const jsonSample = [
  {"name": "Ram", "email": "ram@gmail.com", "age": 23, "DOB": "1990-12-01"},
  {"name": "Shyam", "email": "shyam23@gmail.com", "age": 18, "DOB": "1995-07-01"},
  {"name": "John", "email": "john@gmail.com", "age": 10, "DOB": "2000-02-24"},
  {"name": "Ram", "age": 12, "DOB": "2000-02-01"}
];

class TgPageMainDashboard extends StatelessWidget {
  TgPageMainDashboard({Key? key}) : super(key: key);
  final listContentX = <Widget>[].obs;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Container(
        color: Colors.blueGrey[50],
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TgUtilLoad().ping(),
            Visibility(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () async {
                      TgUtilVal.ping.refresh();
                      EasyLoading.showToast("load Data");
                      await TgUtilLoad().loadFirst();
                      EasyLoading.showToast("data has loaded");
                    },
                    icon: Icon(Icons.refresh)),
              ),
              visible: !sizingInformation.isMobile,
            ),
            // FutureBuilder(
            //   future: onLoad(),
            //   builder: (context, snapshot) => SizedBox.shrink(),
            // ),
            Flexible(
              child: RefreshIndicator(
                onRefresh: () async {
                  EasyLoading.showToast("Load Data ...");
                  TgUtilVal.ping.refresh();
                  await TgUtilLoad().loadFirst();
                },
                child: ListView(
                  children: [
                    TgSubYearToDay(),
                    TgSubTotalRevenueByGroup(),
                    TgSubRevenueByDepartement(),
                    TgSubProductYear(),
                    // TgSubBestProduct()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget listContent() => Obx(
  //       () => ListView.builder(
  //         itemCount: listContentX.length,
  //         itemBuilder: (context, index) => listContentX[index],
  //       ),
  //     );

  // onLoad() async {
  //   await 0.1.delay();
  //   TgUtilPref.report();
  //   TgUtilPref.reportByTotal();
  //   TgUtilPref.reportByGroup();
  //   TgUtilPref.reportByDept();
  //   TgUtilPref.reportByOut();
  //   TgUtilPref.productYearReport();
  //   TgUtilPref.productMonthReport();
  //   TgUtilPref.productWeekReport();
  //   TgUtilPref.productDayReport();

  //   listContentX.assign(TgSubYearToDay());
  //   listContentX.add(SizedBox(height: 20));

  //   listContentX.add(TgSubTotalRevenueByGroup());
  //   listContentX.add(TgSubRevenueByDepartement());
  //   listContentX.add(TgSubProductYear());
  //   listContentX.add(TgSubBestProduct());

  //   await TgUtilLoad().productMonth();
  //   await TgUtilLoad().dashboard();
  //   await TgUtilLoad().productYear();
  //   await TgUtilLoad().productWeek();
  //   await TgUtilLoad().productDay();
  // }
}

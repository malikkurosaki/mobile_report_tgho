import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'tg_util_pref.dart';

class TgThisYear extends StatelessWidget {
  const TgThisYear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TgUtilPref.dashboardReportX.isEmpty
          ? Text("loading ...")
          : Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "This Year",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[700],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            TgUtilPref.dashboardReportX['date'].toString(),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[200],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      // year
                      panel("year", "Year"),
                      panel("month", "Month"),
                      panel("week", "Week"),
                      panel("day", "Day"),
                      // month
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       color: Colors.blueGrey[100],
                      //       width: 300,
                      //       padding: EdgeInsets.all(8),
                      //       margin: EdgeInsets.all(8),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           // month indonesia currency
                      //           Text(
                      //             NumberFormat.currency(
                      //               locale: 'id_ID',
                      //               symbol: 'Rp ',
                      //               decimalDigits: 0,
                      //             ).format(int.tryParse(
                      //                     TgPref.dashboardReportX['data']['month']['_sum']['total'].toString()) ??
                      //                 0),
                      //             style: TextStyle(
                      //               fontSize: 24,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.blueGrey,
                      //             ),
                      //           ),
                      //           Text("Month")
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // week
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       color: Colors.blueGrey[100],
                      //       width: 300,
                      //       padding: EdgeInsets.all(8),
                      //       margin: EdgeInsets.all(8),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           // week indonesia currency
                      //           Text(
                      //             NumberFormat.currency(
                      //               locale: 'id_ID',
                      //               symbol: 'Rp ',
                      //               decimalDigits: 0,
                      //             ).format(int.tryParse(
                      //                     TgPref.dashboardReportX['data']['week']['_sum']['total'].toString()) ??
                      //                 0),
                      //             style: TextStyle(
                      //               fontSize: 24,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.blueGrey,
                      //             ),
                      //           ),
                      //           Text("Week")
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // day
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       color: Colors.blueGrey[100],
                      //       width: 300,
                      //       padding: EdgeInsets.all(8),
                      //       margin: EdgeInsets.all(8),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           // day indonesia currency
                      //           Text(
                      //             NumberFormat.currency(
                      //               locale: 'id_ID',
                      //               symbol: 'Rp ',
                      //               decimalDigits: 0,
                      //             ).format(int.tryParse(
                      //                     TgPref.dashboardReportX['data']['day']['_sum']['total'].toString()) ??
                      //                 0),
                      //             style: TextStyle(
                      //               fontSize: 24,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.blueGrey,
                      //             ),
                      //           ),
                      //           Text("Day")
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget panel(String titleData, String title) {
    return Container(
      margin: EdgeInsets.all(8),
      color: Colors.blueGrey[100],
      width: 300,
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.blueGrey[100],
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // year indonesia currency
            Text(
              NumberFormat.currency(
                locale: 'id_ID',
                symbol: 'Rp ',
                decimalDigits: 0,
              ).format(int.tryParse(TgUtilPref.dashboardReportX['data'][titleData]['_sum']['total'].toString()) ?? 0),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            Text(title)
          ],
        ),
        children: [
          for (final d in Map.from(TgUtilPref.dashboardReportX['data'][titleData]['_sum']).keys)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(d.toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),),
                  Text(
                    (TgUtilPref.dashboardReportX['data'][titleData]['_sum'][d]??0).toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:isolate';

import 'package:d_chart/d_chart.dart';
import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isolated_worker/isolated_worker.dart';
import 'package:json_table/json_table.dart';
import 'package:mobile_report/tgho/tg_dept_report.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';
import 'package:mobile_report/tgho/tg_product_report.dart';
import 'package:mobile_report/tgho/tg_revenue.dart';
import 'package:mobile_report/tgho/tg_this_year.dart';
import 'package:mobile_report/tgho/tg_util_gval.dart';
import 'package:mobile_report/tgho/tg_util_load.dart';
import 'package:mobile_report/tgho/tg_util_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'tg_conn.dart';
import 'tg_performance.dart';

const jsonSample = [
  {"name": "Ram", "email": "ram@gmail.com", "age": 23, "DOB": "1990-12-01"},
  {"name": "Shyam", "email": "shyam23@gmail.com", "age": 18, "DOB": "1995-07-01"},
  {"name": "John", "email": "john@gmail.com", "age": 10, "DOB": "2000-02-24"},
  {"name": "Ram", "age": 12, "DOB": "2000-02-01"}
];

class TgMainDashboard extends StatelessWidget {
  const TgMainDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Container(
        color: Colors.blueGrey[50],
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            FutureBuilder(
              future: onLoad(),
              builder: (context, snapshot) => SizedBox.shrink(),
            ),
            Flexible(
              child: Obx(() => RefreshIndicator(
                onRefresh: () async {
                  EasyLoading.showToast("Load Data ...");
                  await onLoad();

                },
                child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TgUtilPref.reportX.isEmpty
                            ? Text("loading ...")
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Obx(
                                            () => Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Visibility(
                                                visible: TgUtilGVal.sncData.value,
                                                child: CircularProgressIndicator(
                                                  backgroundColor: Colors.blueGrey[100],
                                                  color: Colors.blueGrey,
                                                  strokeWidth: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.refresh),
                                        onPressed: () async {
                                          EasyLoading.showToast("load data ...");
                                          await onLoad();
                                          EasyLoading.showToast("data loaded");
                                        },
                                      ),
                                    ],
                                  ),
                                  // title revenue rear to day
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Revenue Year To Day",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey[300],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(bottom: 24),
                                    color: Colors.blueGrey[230],
                                    child: Wrap(
                                      children: [
                                        for (final r in TgUtilPref.reportByTotalX.keys)
                                          Card(
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              width: sizingInformation.isMobile ? 500 : Get.width / 4,
                                              height: 230,
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Image.network(
                                                      "https://i.postimg.cc/bY5Ppn8Z/image.png",
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      cacheHeight: 230,
                                                      cacheWidth: 230,
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.9)),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "This " + r.toString(),
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.cyan),
                                                      ),
                                                      Text(
                                                        DateFormat("dd MMMM yyyy").format(
                                                            DateTime.parse(TgUtilPref.reportX['date'].toString())),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontStyle: FontStyle.italic,
                                                            color: Colors.grey),
                                                      ),
                                                      Divider(),
                                                      // gross
                                                      Text("GROSS"),
                                                      Text(
                                                        NumberFormat.currency(
                                                                locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                                                            .format(
                                                          int.tryParse(
                                                            (TgUtilPref.reportByTotalX[r]['_sum']['total'] ?? 0)
                                                                .toString(),
                                                          ),
                                                        ),
                                                        textAlign: TextAlign.start,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.blueGrey[200],
                                                        ),
                                                      ),
                                                      // net
                                                      Text("NET"),
                                                      Text(
                                                        NumberFormat.currency(
                                                                locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                                                            .format(
                                                          int.tryParse(
                                                            (TgUtilPref.reportByTotalX[r]['_sum']['net'] ?? 0).toString(),
                                                          ),
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.blueGrey,
                                                        ),
                                                      ),
                                                      // pax
                                                      Text("PAX"),
                                                      Text(
                                                        (TgUtilPref.reportByTotalX[r]['_sum']['pax'] ?? 0).toString(),
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.teal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  // title revenue by group
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Revenue By Group Category",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey[300],
                                      ),
                                    ),
                                  ),
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 500,
                                        height: 500,
                                        child: Card(
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                "https://i.postimg.cc/nrNYh2cV/image.png",
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                height: double.infinity,
                                                cacheHeight: 230,
                                                cacheWidth: 230,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.9)),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          DateFormat("dd MMMM yyyy").format(
                                                              DateTime.parse(TgUtilPref.reportX['date'].toString())),
                                                          style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                        Divider(),
                                                        for (final i in TgUtilPref.reportByGroupX)
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text(
                                                                i['group'].toString(),
                                                                style: TextStyle(color: Colors.grey),
                                                              )),
                                                              Text(
                                                                NumberFormat.currency(
                                                                        locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                                                                    .format(
                                                                  int.tryParse(
                                                                    (i["data"]['year']['data']['_sum']['total'] ?? 0)
                                                                        .toString(),
                                                                  ),
                                                                ),
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.blueGrey,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                      ],
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(32),
                                                        child: DChartPie(
                                                          donutWidth: 200,
                                                          labelFontSize: 14,
                                                          labelColor: Colors.brown,
                                                          // labelPosition: PieLabelPosition.outside,
                                                          pieLabel: (a, b) => "${a['domain']}\n${a['measure']}",
                                                          fillColor: (a, b) => a['domain'] == "BEVERAGE"
                                                              ? Colors.orange[100]
                                                              : a['domain'] == "FOOD"
                                                                  ? Colors.teal[100]
                                                                  : Colors.cyan[100],
                                                          data: [
                                                            for (final i in TgUtilPref.reportByGroupX)
                                                              {
                                                                "domain": i['group'],
                                                                "measure": int.parse((i["data"]['year']['data']['_sum']
                                                                                    ['total']
                                                                                .toString() ==
                                                                            "null"
                                                                        ? "0"
                                                                        : i["data"]['year']['data']['_sum']['total'])
                                                                    .toString())
                                                              },
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 600,
                                        child: Center(
                                          child: Wrap(
                                            children: [
                                              for (final i in TgUtilPref.reportByGroupX)
                                                Card(
                                                  child: Container(
                                                    width: sizingInformation.isMobile ? 500 : 250,
                                                    child: Container(
                                                      padding: EdgeInsets.all(8),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            i['group'].toString(),
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                                fontStyle: FontStyle.italic,
                                                                color: Colors.green),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                                                    i['data']['year']['date']['start'].toString())),
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.grey,
                                                                ),
                                                              ),
                                                              Text(
                                                                DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                                                    i['data']['year']['date']['end'].toString())),
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("This Month", style: TextStyle(color: Colors.grey)),
                                                              Text(
                                                                  (i['data']['month']['data']['_sum']['total'] ?? 0)
                                                                      .toString(),
                                                                  style: TextStyle(color: Colors.green)),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("This Week", style: TextStyle(color: Colors.grey)),
                                                              Text(
                                                                  (i['data']['week']['data']['_sum']['total'] ?? 0)
                                                                      .toString(),
                                                                  style: TextStyle(color: Colors.green)),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("Today", style: TextStyle(color: Colors.grey)),
                                                              Text(
                                                                (i['data']['day']['data']['_sum']['total'] ?? 0)
                                                                    .toString(),
                                                                style: TextStyle(color: Colors.green),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  // title revenue by departement
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Revenue By Departement",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey[300],
                                      ),
                                    ),
                                  ),
                                  TgUtilPref.reportByDeptX.isEmpty
                                      ? Center(
                                          child: Text("loading ..."),
                                        )
                                      : Wrap(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Card(
                                                  child: SizedBox(
                                                    width: 500,
                                                    height: 700,
                                                    child: Stack(
                                                      children: [
                                                        Image.network(
                                                          "https://i.postimg.cc/P59M80vb/image.png",
                                                          filterQuality: FilterQuality.low,
                                                          fit: BoxFit.cover,
                                                          width: double.infinity,
                                                          height: double.infinity,
                                                          cacheHeight: 230,
                                                          cacheWidth: 230,
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(24),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Wrap(
                                                                children: [
                                                                  for (final i in TgUtilPref.reportByDeptX)
                                                                    Container(
                                                                      padding: EdgeInsets.all(8),
                                                                      width: 200,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(i['dept'].toString(),
                                                                              style: TextStyle(color: Colors.grey)),
                                                                          Text(
                                                                              NumberFormat.currency(
                                                                                      locale: "id_ID",
                                                                                      symbol: "Rp",
                                                                                      decimalDigits: 0)
                                                                                  .format(int.parse((i['data']['year']
                                                                                              ['data']['_sum']['total'] ??
                                                                                          0)
                                                                                      .toString())),
                                                                              style: TextStyle(
                                                                                  color: Colors.green,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 18)),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                              Flexible(
                                                                child: DChartBar(
                                                                    domainLabelPaddingToTick: 10,
                                                                    domainLabelRotation: 45,
                                                                    barColor: (a, b, c) {
                                                                      final listColor = [
                                                                        Colors.blue[100],
                                                                        Colors.green[100],
                                                                        Colors.red[100],
                                                                        Colors.yellow[100],
                                                                        Colors.orange[100],
                                                                        Colors.purple[100],
                                                                        Colors.pink[100],
                                                                        Colors.brown[100],
                                                                        Colors.grey[100],
                                                                        Colors.cyan[100],
                                                                        Colors.indigo[100],
                                                                        Colors.lime[100],
                                                                        Colors.teal[100],
                                                                        Colors.lightBlue[100],
                                                                        Colors.lightGreen[100],
                                                                        Colors.blue[100],
                                                                        Colors.green[100],
                                                                        Colors.red[100],
                                                                        Colors.yellow[100],
                                                                        Colors.orange[100],
                                                                        Colors.purple[100],
                                                                        Colors.pink[100],
                                                                        Colors.brown[100],
                                                                        Colors.grey[100],
                                                                        Colors.cyan[100],
                                                                        Colors.indigo[100],
                                                                        Colors.lime[100],
                                                                        Colors.teal[100],
                                                                        Colors.lightBlue[100],
                                                                        Colors.lightGreen[100],
                                                                      ];
              
                                                                      return listColor[b!]!;
                                                                    },
                                                                    data: [
                                                                      {
                                                                        "id": "dept",
                                                                        "data": [
                                                                          for (final i in TgUtilPref.reportByDeptX)
                                                                            {
                                                                              "domain": i['dept']
                                                                                  .toString()
                                                                                  .split(" ")[0]
                                                                                  .toString(),
                                                                              "measure": int.parse((i["data"]['year']
                                                                                                      ['data']['_sum']
                                                                                                  ['total']
                                                                                              .toString() ==
                                                                                          "null"
                                                                                      ? "0"
                                                                                      : i["data"]['year']['data']['_sum']
                                                                                          ['total'])
                                                                                  .toString())
                                                                            }
                                                                        ]
                                                                      }
                                                                    ]),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Card(
                                                  child: SizedBox(
                                                    width: 500,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(16),
                                                      child: Column(
                                                        children: [
                                                          for (final i in TgUtilPref.reportByDeptX)
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      i['dept'].toString(),
                                                                    ),
                                                                    Text(
                                                                      NumberFormat.currency(
                                                                        locale: 'id_ID',
                                                                        symbol: 'Rp',
                                                                        decimalDigits: 0,
                                                                      ).format(
                                                                        int.parse(
                                                                          (i["data"]['year']['data']['_sum']['total'] ??
                                                                                  0)
                                                                              .toString(),
                                                                        ),
                                                                      ),
                                                                      style: TextStyle(
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontStyle: FontStyle.italic,
                                                                        color: Colors.teal,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider()
                                                              ],
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 600,
                                              child: Wrap(
                                                children: [
                                                  for (final i in TgUtilPref.reportByDeptX)
                                                    Card(
                                                      child: Container(
                                                        width: sizingInformation.isMobile ? 230 : 290,
                                                        padding: const EdgeInsets.all(16),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              i['dept'].toString(),
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                                fontStyle: FontStyle.italic,
                                                                color: Colors.teal,
                                                              ),
                                                            ),
                                                            Divider(),
                                                            // month
                                                            Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(
                                                                "This Month",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.blueGrey,
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                                                      i['data']['month']['date']['start'].toString())),
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                                                      i['data']['month']['date']['end'].toString())),
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              NumberFormat("#,###").format(int.tryParse(i['data']['month']
                                                                          ['data']['_sum']['total']
                                                                      .toString()) ??
                                                                  0),
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                                fontStyle: FontStyle.italic,
                                                                color: Colors.teal,
                                                              ),
                                                            ),
                                                            Divider(),
                                                            // week
                                                            Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(
                                                                "This Week",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.blueGrey,
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                                                      i['data']['week']['date']['start'].toString())),
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                                                      i['data']['week']['date']['end'].toString())),
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              NumberFormat("#,###").format(int.tryParse(i['data']['week']
                                                                          ['data']['_sum']['total']
                                                                      .toString()) ??
                                                                  0),
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                                fontStyle: FontStyle.italic,
                                                                color: Colors.teal,
                                                              ),
                                                            ),
                                                            Divider(),
                                                            // day
                                                            Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(
                                                                "Today",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.blueGrey,
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                                                      i['data']['day']['date']['start'].toString())),
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                                                      i['data']['day']['date']['end'].toString())),
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              NumberFormat("#,###").format(int.tryParse(i['data']['day']
                                                                          ['data']['_sum']['total']
                                                                      .toString()) ??
                                                                  0),
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                                fontStyle: FontStyle.italic,
                                                                color: Colors.teal,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                  Divider(),
                                  Text(
                                    "Best Product",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey[300],
                                    ),
                                  ),
                                  TgUtilPref.productYearReportX.isEmpty
                                      ? Text("loading")
                                      : Wrap(
                                          children: [
                                            SizedBox(
                                              width: 500,
                                              height: 700,
                                              child: Card(
                                                child: Stack(
                                                  children: [
                                                    Image.network(
                                                      "https://i.postimg.cc/PxmT1G6B/image.png",
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                      height: double.infinity,
                                                      cacheHeight: 230,
                                                      cacheWidth: 230,
                                                    ),
                                                    Container(
                                                      color: Colors.white.withOpacity(0.8),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(32),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                                                    TgUtilPref.productYearReportX['date']['start']
                                                                        .toString())),
                                                                style: TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey),
                                                              ),
                                                              Text(
                                                                DateFormat("dd MMMM yyyy").format(DateTime.parse(
                                                                    TgUtilPref.productYearReportX['date']['end']
                                                                        .toString())),
                                                                style: TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey),
                                                              ),
                                                            ],
                                                          ),
                                                          Wrap(
                                                            children: [
                                                              for (final i in TgUtilPref.productYearReportX['data'])
                                                                Container(
                                                                  width: 200,
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        i['nama_pro'].toString(),
                                                                        style:
                                                                            TextStyle(fontSize: 14, color: Colors.grey),
                                                                      ),
                                                                      Text(
                                                                        NumberFormat.currency(
                                                                                locale: "id_ID",
                                                                                decimalDigits: 0,
                                                                                symbol: "Rp")
                                                                            .format(int.tryParse(i['totalValue'] ?? 0)),
                                                                        style: TextStyle(
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontStyle: FontStyle.italic,
                                                                          color: Colors.blueGrey,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                          Flexible(
                                                            child: DChartBar(
                                                              data: [
                                                                {
                                                                  "id": "product year",
                                                                  "data": [
                                                                    for (final pie
                                                                        in TgUtilPref.productYearReportX['data'])
                                                                      {
                                                                        "domain": pie['nama_pro']
                                                                            .toString()
                                                                            .split(" ")[0]
                                                                            .toString(),
                                                                        "measure":
                                                                            int.parse((pie['totalValue'] ?? 0).toString())
                                                                      },
                                                                  ]
                                                                },
                                                              ],
                                                              barColor:
                                                                  (Map<String, dynamic> barData, int? index, String id) {
                                                                final listColor = [
                                                                  Colors.blue.withOpacity(0.5),
                                                                  Colors.green.withOpacity(0.5),
                                                                  Colors.red.withOpacity(0.5),
                                                                  Colors.yellow.withOpacity(0.5),
                                                                  Colors.orange.withOpacity(0.5),
                                                                  Colors.purple.withOpacity(0.5),
                                                                  Colors.pink.withOpacity(0.5),
                                                                  Colors.cyan.withOpacity(0.5),
                                                                  Colors.brown.withOpacity(0.5),
                                                                  Colors.grey.withOpacity(0.5),
                                                                  Colors.indigo.withOpacity(0.5),
                                                                  Colors.lime.withOpacity(0.5),
                                                                  Colors.lightBlue.withOpacity(0.5),
                                                                  Colors.lightGreen.withOpacity(0.5),
                                                                  Colors.orangeAccent.withOpacity(0.5),
                                                                  Colors.teal.withOpacity(0.5),
                                                                  Colors.deepOrange.withOpacity(0.5),
                                                                  Colors.deepPurple.withOpacity(0.5),
                                                                  Colors.indigoAccent.withOpacity(0.5),
                                                                  Colors.limeAccent.withOpacity(0.5),
                                                                  Colors.lightBlueAccent.withOpacity(0.5),
                                                                  Colors.lightGreenAccent.withOpacity(0.5),
                                                                  Colors.pinkAccent.withOpacity(0.5),
                                                                  Colors.purpleAccent.withOpacity(0.5),
                                                                  Colors.cyanAccent.withOpacity(0.5),
                                                                  Colors.brown.withOpacity(0.5)
                                                                ];
                                                                return listColor[index!];
                                                              },
                                                              showBarValue: true,
                                                              showDomainLine: true,
                                                              domainLabelRotation: 45,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            TgUtilPref.productMonthReportX.isEmpty
                                                ? Center(
                                                    child: Text(""),
                                                  )
                                                : SizedBox(
                                                    width: 600,
                                                    height: 700,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text("Product Month, Week, Day Report",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.blueGrey)),
                                                        ),
                                                        Wrap(
                                                          children: [
                                                            SizedBox(
                                                              width: 200,
                                                              child: ListTile(
                                                                leading: Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    color: Colors.blue.withOpacity(0.5)),
                                                                title: Text(
                                                                  "Month",
                                                                  style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.blueGrey),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 200,
                                                              child: ListTile(
                                                                leading: Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    color: Colors.green.withOpacity(0.5)),
                                                                title: Text(
                                                                  "Week",
                                                                  style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.blueGrey),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 200,
                                                              child: ListTile(
                                                                leading: Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    color: Colors.red.withOpacity(0.5)),
                                                                title: Text(
                                                                  "Day",
                                                                  style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.blueGrey),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Flexible(
                                                          child: Card(
                                                            child: Stack(
                                                              children: [
                                                                Image.network(
                                                                  "https://i.postimg.cc/zXDW03JZ/image.png",
                                                                  width: double.infinity,
                                                                  height: double.infinity,
                                                                  fit: BoxFit.cover,
                                                                  cacheHeight: 200,
                                                                  cacheWidth: 200,
                                                                ),
                                                                Container(color: Colors.white.withOpacity(0.9)),
                                                                SingleChildScrollView(
                                                                  scrollDirection: Axis.horizontal,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(32),
                                                                    child: SizedBox(
                                                                      width: 1280,
                                                                      child: DChartBar(
                                                                        data: [
                                                                          {
                                                                            "id": "month",
                                                                            "data": [
                                                                              for (final pie in TgUtilPref
                                                                                  .productMonthReportX['data'])
                                                                                {
                                                                                  "domain": pie['nama_pro']
                                                                                      .toString()
                                                                                      .split(" ")[0]
                                                                                      .toString(),
                                                                                  "measure": int.tryParse(
                                                                                          pie['totalValue'].toString()) ??
                                                                                      0,
                                                                                },
                                                                            ]
                                                                          },
                                                                          {
                                                                            "id": "week",
                                                                            "data": [
                                                                              for (final pie in TgUtilPref
                                                                                  .prowductWeekReportX['data'])
                                                                                {
                                                                                  "domain": pie['nama_pro']
                                                                                      .toString()
                                                                                      .split(" ")[0]
                                                                                      .toString(),
                                                                                  "measure": int.tryParse(
                                                                                          pie['totalValue'].toString()) ??
                                                                                      0,
                                                                                },
                                                                            ]
                                                                          },
                                                                          {
                                                                            "id": "day",
                                                                            "data": [
                                                                              for (final pie
                                                                                  in TgUtilPref.productDayReportX['data'])
                                                                                {
                                                                                  "domain": pie['nama_pro']
                                                                                      .toString()
                                                                                      .split(" ")[0]
                                                                                      .toString(),
                                                                                  "measure": int.tryParse(
                                                                                          pie['totalValue'].toString()) ??
                                                                                      0,
                                                                                },
                                                                            ]
                                                                          }
                                                                        ],
                                                                        barColor: (a, b, c) {
                                                                          return c == "month"
                                                                              ? Colors.blue.withOpacity(0.5)
                                                                              : c == "week"
                                                                                  ? Colors.green.withOpacity(0.5)
                                                                                  : Colors.red.withOpacity(0.5);
                                                                        },
                                                                        showBarValue: true,
                                                                        showDomainLine: true,
                                                                        domainLabelRotation: 45,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                          ],
                                        )
                                ],
                              )
                      ],
                    ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  onLoad() async {
    await 0.1.delay();
    //TgUtilGVal.sncData.value = true;

    TgUtilPref.report();
    TgUtilPref.reportByTotal();
    TgUtilPref.reportByGroup();
    TgUtilPref.reportByDept();
    TgUtilPref.reportByOut();
    TgUtilPref.productYearReport();
    TgUtilPref.productMonthReport();
    TgUtilPref.productWeekReport();
    TgUtilPref.productDayReport();

    await TgUtilLoad().productMonth();
    await TgUtilLoad().dashboard();
    await TgUtilLoad().productYear();
    await TgUtilLoad().productWeek();
    await TgUtilLoad().productDay();

    //TgUtilGVal.sncData.value = false;
  }
}

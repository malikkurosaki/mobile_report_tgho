import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

import 'tg_util_pref.dart';

class TgSubProductYear extends StatelessWidget {
  const TgSubProductYear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TgUtilPref.productYearReportX.isEmpty
          ? Text("loading ...")
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    "Product By Year",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ),
                Wrap(
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
                                      Expanded(
                                        child: Text(
                                          DateFormat("dd MMMM yyyy").format(
                                              DateTime.parse(TgUtilPref.productYearReportX['date']['start'].toString())),
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          DateFormat("dd MMMM yyyy").format(
                                              DateTime.parse(TgUtilPref.productYearReportX['date']['end'].toString())),
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Wrap(
                                    children: [
                                      for (final i in TgUtilPref.productYearReportX['data'])
                                        SizedBox(
                                          width: 150,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                i['nama_pro'].toString(),
                                                style: TextStyle(fontSize: 14, color: Colors.grey),
                                              ),
                                              Text(
                                                NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: "Rp")
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
                                            for (final pie in TgUtilPref.productYearReportX['data'])
                                              {
                                                "domain": pie['nama_pro'].toString().split(" ")[0].toString(),
                                                "measure": int.parse((pie['totalValue'] ?? 0).toString())
                                              },
                                          ]
                                        },
                                      ],
                                      barColor: (Map<String, dynamic> barData, int? index, String id) {
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
                    TgUtilPref.productMonthReportX.isEmpty || TgUtilPref.prowductWeekReportX.isEmpty || TgUtilPref.productDayReportX.isEmpty
                        ? Center(
                            child: Text("load data ..."),
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
                                      style:
                                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                                ),
                                Wrap(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: ListTile(
                                        leading: Container(height: 20, width: 20, color: Colors.blue.withOpacity(0.5)),
                                        title: Text(
                                          "Month",
                                          style: TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: ListTile(
                                        leading: Container(height: 20, width: 20, color: Colors.green.withOpacity(0.5)),
                                        title: Text(
                                          "Week",
                                          style: TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: ListTile(
                                        leading: Container(height: 20, width: 20, color: Colors.red.withOpacity(0.5)),
                                        title: Text(
                                          "Day",
                                          style: TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
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
                                                      for (final pie in TgUtilPref.productMonthReportX['data'])
                                                        {
                                                          "domain": pie['nama_pro'].toString().split(" ")[0].toString(),
                                                          "measure": int.tryParse(pie['totalValue'].toString()) ?? 0,
                                                        },
                                                    ]
                                                  },
                                                  {
                                                    "id": "week",
                                                    "data": [
                                                      for (final pie in TgUtilPref.prowductWeekReportX['data'])
                                                        {
                                                          "domain": pie['nama_pro'].toString().split(" ")[0].toString(),
                                                          "measure": int.tryParse(pie['totalValue'].toString()) ?? 0,
                                                        },
                                                    ]
                                                  },
                                                  {
                                                    "id": "day",
                                                    "data": [
                                                      for (final pie in TgUtilPref.productDayReportX['data'])
                                                        {
                                                          "domain": pie['nama_pro'].toString().split(" ")[0].toString(),
                                                          "measure": int.tryParse(pie['totalValue'].toString()) ?? 0,
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
            ),
    );
  }
}

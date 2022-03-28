import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';

class TgProductReport extends StatelessWidget {
  const TgProductReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onLoad();
    return Obx(
      () => Material(
        child: Column(
          children: [
            Row(
              children: [
                BackButton(),
                Text("Product Report"),
              ],
            ),
            Wrap(
              children: [
                Text(TgUtilPref.productYearReportX['date']['start'].toString(),
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Text(TgUtilPref.productYearReportX['date']['end'].toString(),
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey
                  ),
                ),
              ],
            ),
            // Text(TgPref.productYearReportX['date'].toString()),
            // Text(TgPref.productYearReportX['data'].toString()),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(24),
                      child: LimitedBox(
                        maxHeight: 300,
                        maxWidth: 500,
                        child: DChartBar(
                          barColor: (a, b, c) => Colors.blue,
                          data: [
                            {
                              "id": "Bar",
                              "data": [
                                for (final x in TgUtilPref.productYearReportX['data'])
                                  {
                                    "domain": x['nama_pro'],
                                    "measure": int.parse(x['totalValue'].toString()),
                                  }
                              ]
                            }
                          ],
                          measureLabelFontSize: 12,
                          domainLabelRotation: 42,
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text("Detail"),
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Card(
                            child: Table(
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Name"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Total"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Total"),
                                    ),
                                  ],
                                ),
                                for (final x in TgUtilPref.productYearReportX['data'])
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(x['nama_pro'].toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(x['totalBill'].toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(x['totalValue'].toString()),
                                    ),
                                  ])
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  onLoad() async {
    // product year
    // await TgUtilLoad.productYear();

    // // product month
    // TgUtilLoad.productMonth();

    // // week
    // TgUtilLoad.productWeek();

    // // product day
    // TgUtilLoad.productDay();
  }
}

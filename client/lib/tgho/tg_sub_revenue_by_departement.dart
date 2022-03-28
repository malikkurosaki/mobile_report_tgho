import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'tg_util_pref.dart';

class TgSubRevenueByDepartement extends StatelessWidget {
  const TgSubRevenueByDepartement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Obx(
        () => TgUtilPref.reportByDeptX.isEmpty
            ? Text("loading...")
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                                      width: 150,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(i['dept'].toString(),
                                                              style: TextStyle(color: Colors.grey)),
                                                          Text(
                                                              NumberFormat.currency(
                                                                      locale: "id_ID", symbol: "Rp", decimalDigits: 0)
                                                                  .format(int.parse(
                                                                      (i['data']['year']['data']['_sum']['total'] ?? 0)
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
                                                              "domain": i['dept'].toString().split(" ")[0].toString(),
                                                              "measure": int.parse((i["data"]['year']['data']['_sum']
                                                                                  ['total']
                                                                              .toString() ==
                                                                          "null"
                                                                      ? "0"
                                                                      : i["data"]['year']['data']['_sum']['total'])
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
                                                          (i["data"]['year']['data']['_sum']['total'] ?? 0).toString(),
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
                                        width: sizingInformation.isMobile ? 180 : 290,
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
                                                Expanded(
                                                  child: Text(
                                                    DateFormat("dd MMMM yyyy").format(
                                                        DateTime.parse(i['data']['month']['date']['start'].toString())),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    DateFormat("dd MMMM yyyy").format(
                                                        DateTime.parse(i['data']['month']['date']['end'].toString())),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              NumberFormat("#,###").format(int.tryParse(
                                                      i['data']['month']['data']['_sum']['total'].toString()) ??
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
                                                Expanded(
                                                  child: Text(
                                                    DateFormat("dd MMMM yyyy").format(
                                                        DateTime.parse(i['data']['week']['date']['start'].toString())),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    DateFormat("dd MMMM yyyy").format(
                                                        DateTime.parse(i['data']['week']['date']['end'].toString())),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              NumberFormat("#,###").format(
                                                  int.tryParse(i['data']['week']['data']['_sum']['total'].toString()) ??
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
                                                Expanded(
                                                  child: Text(
                                                    DateFormat("dd MMMM yyyy").format(
                                                        DateTime.parse(i['data']['day']['date']['start'].toString())),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    DateFormat("dd MMMM yyyy").format(
                                                        DateTime.parse(i['data']['day']['date']['end'].toString())),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              NumberFormat("#,###").format(
                                                  int.tryParse(i['data']['day']['data']['_sum']['total'].toString()) ??
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
                        )
                ],
              ),
      ),
    );
  }
}

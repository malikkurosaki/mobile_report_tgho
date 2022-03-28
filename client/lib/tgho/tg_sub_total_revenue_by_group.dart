import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'tg_util_pref.dart';

class TgSubTotalRevenueByGroup extends StatelessWidget {
  const TgSubTotalRevenueByGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Obx(
        () => TgUtilPref.reportX.isEmpty
            ? Text("loading ...")
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                          DateFormat("dd MMMM yyyy")
                                              .format(DateTime.parse(TgUtilPref.reportX['date'].toString())),
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
                                                NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                                                    .format(
                                                  int.tryParse(
                                                    (i["data"]['year']['data']['_sum']['total'] ?? 0).toString(),
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
                                                "measure": int.parse(
                                                    (i["data"]['year']['data']['_sum']['total'].toString() == "null"
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
                                                DateFormat("dd MMMM yyyy").format(
                                                    DateTime.parse(i['data']['year']['date']['start'].toString())),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                DateFormat("dd MMMM yyyy").format(
                                                    DateTime.parse(i['data']['year']['date']['end'].toString())),
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
                                              Text((i['data']['month']['data']['_sum']['total'] ?? 0).toString(),
                                                  style: TextStyle(color: Colors.green)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("This Week", style: TextStyle(color: Colors.grey)),
                                              Text((i['data']['week']['data']['_sum']['total'] ?? 0).toString(),
                                                  style: TextStyle(color: Colors.green)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Today", style: TextStyle(color: Colors.grey)),
                                              Text(
                                                (i['data']['day']['data']['_sum']['total'] ?? 0).toString(),
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
                  )
                ],
              ),
      ),
    );
  }
}

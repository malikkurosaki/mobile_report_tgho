import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile_report/tgho/tg_util_val.dart';
import 'package:get/get.dart';
import 'tg_conn.dart';

class TgProductReport extends StatelessWidget {
  const TgProductReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: TgUtilVal.listProductReportYear.toString() == '[]',
          child: FutureBuilder(
            future: onLoad(),
            builder: (context, snapshot) => CircularProgressIndicator(),
          ),
        ),
        Flexible(
          child: Obx(() => Material(
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          BackButton(),
                          Expanded(child: Text("Product")),
                        ],
                      ),
                      Flexible(
                          child: SingleChildScrollView(
                        child: Wrap(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 500),
                              child: Column(
                                children: [
                                  TgUtilVal.listProductReportYear.toString() ==
                                          "[]"
                                      ? Text("loading")
                                      : Card(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              height: 400,
                                              width: 400,
                                              child: DChartGauge(
                                                donutWidth: 200,
                                                data: [
                                                  for (final y in TgUtilVal
                                                      .listProductReportYear)
                                                    {
                                                      "domain": "apa",
                                                      "measure": 20
                                                    }
                                                ],
                                                fillColor: (a, b) => Colors.blue,
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }

  onLoad() async {
    try {
      print("load product report");
      final data = await TgConn().getProductReportYear();
      TgUtilVal.listProductReportYear.assignAll(List.from(data.body));
    } catch (e) {
      print(e);
    }
  }
}

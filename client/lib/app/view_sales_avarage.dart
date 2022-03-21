/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:mobile_report/Val.dart';
import 'package:mobile_report/models.dart';
import 'package:get/get.dart';

class ViewSalesAvarage extends StatelessWidget {
  final bool? animate;
  ViewSalesAvarage({Key? key, this.animate}) : super(key: key);
  final listBulan = [
    {"nom": 1, "name": "January"},
    {"nom": 2, "name": "February"},
    {"nom": 3, "name": "March"},
    {"nom": 4, "name": "April"},
    {"nom": 5, "name": "May"},
    {"nom": 6, "name": "June"},
    {"nom": 7, "name": "July"},
    {"nom": 8, "name": "August"},
    {"nom": 9, "name": "September"},
    {"nom": 10, "name": "	October"},
    {"nom": 11, "name": "	November"},
    {"nom": 12, "name": "	December"}
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Text("Sales Analisys By Avarage",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.green
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      DateTime.parse(Val.tgl1.value.toString()).year.toString(),
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400])),
                  Text(
                      DateTime.parse(Val.tgl2.value.toString()).year.toString(),
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400])),
                ],
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: Get.height / 2,
                width: Get.width + 200,
                child: charts.BarChart(
                  [
                    charts.Series<ModelSalesAvarage, String>(
                      id: 'Sales',
                      
                      colorFn: (_, __) =>
                          charts.MaterialPalette.green.shadeDefault,
                      domainFn: (ModelSalesAvarage sales, _) =>
                          sales.bulan.toString(),
                      measureFn: (ModelSalesAvarage sales, _) => sales.net,
                      data: Val.listSalesAvarage,
                    )
                  ],
                  animate: animate,
                  defaultInteractions: true,
                  behaviors: [
                    charts.SelectNearest(),
                    charts.DomainHighlighter()
                  ],
                ),
              ),
            ),
            for (final a in Val.listSalesAvarage)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(listBulan[a.bulan! - 1]['name'].toString(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]
                              )
                            ),
                          ),
                        ),
                        SizedBox(width: 20,)
,                        Expanded(
                          flex: 1,
                          child: Text(a.net.toString(),
                             style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider()
                ],
              )
          ],
        ));
  }

  // static List<charts.Series<ModelSalesPerformance, String>>
  //     _createSampleData() {
  //   return [
  //     charts.Series<ModelSalesPerformance, String>(
  //       id: 'Sales',
  //       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
  //       domainFn: (ModelSalesPerformance sales, _) => sales.bulan.toString(),
  //       measureFn: (ModelSalesPerformance sales, _) => sales.net,
  //       data: Val.listSalesperformance,
  //     )
  //   ];
  // }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:mobile_report/models.dart';
import 'package:mobile_report/v2_util.dart';
import 'package:mobile_report/v2_val.dart';
import 'package:charts_flutter/flutter.dart' hide TextStyle;

class V2SalesPerformanceWeek extends StatelessWidget {
  const V2SalesPerformanceWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange[50],
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sales Performance Day",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat.yMEd().format(V2Val.tanggal1.value),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  InputChip(
                    label: Text(V2Val.dep.value.namaDept.toString()),
                    avatar: Icon(
                      Icons.home_work_outlined,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                children: [
                  V2Val.salesPerformanceWeek.value.food == null
                      ? Text("Emply")
                      : SizedBox(
                          height: 300,
                          child: Card(
                            child: BarChart([
                              Series<Food, String>(
                                id: "Week",
                                fillColorFn: (datum, index) =>
                                    MaterialPalette.green.shadeDefault,
                                data: List.generate(
                                    V2Val.salesPerformanceWeek.value.food!
                                        .length,
                                    (i) => V2Val
                                        .salesPerformanceWeek.value.food![i]),
                                domainFn: (datum, index) =>
                                    DateTime.parse(datum.tanggal!)
                                        .day
                                        .toString(),
                                measureFn: (datum, index) =>
                                    int.parse(datum.total.toString()),
                              ),
                              Series<Food, String>(
                                id: "Week",
                                fillColorFn: (datum, index) =>
                                    MaterialPalette.red.shadeDefault,
                                data: List.generate(
                                    V2Val.salesPerformanceWeek.value.beverage!
                                        .length,
                                    (i) => V2Val.salesPerformanceWeek.value
                                        .beverage![i]),
                                domainFn: (datum, index) =>
                                    DateTime.parse(datum.tanggal!)
                                        .day
                                        .toString(),
                                measureFn: (datum, index) =>
                                    int.parse(datum.total.toString()),
                              ),
                              Series<Food, String>(
                                id: "Week",
                                fillColorFn: (datum, index) =>
                                    MaterialPalette.deepOrange.shadeDefault,
                                data: List.generate(
                                    V2Val.salesPerformanceWeek.value.other!
                                        .length,
                                    (i) => V2Val
                                        .salesPerformanceWeek.value.other![i]),
                                domainFn: (datum, index) =>
                                    DateTime.parse(datum.tanggal!)
                                        .day
                                        .toString(),
                                measureFn: (datum, index) =>
                                    int.parse(datum.total.toString()),
                              )
                            ]),
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

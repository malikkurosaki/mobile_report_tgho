import 'package:charts_flutter/flutter.dart' hide TextStyle;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:mobile_report/v2_val.dart';
import 'package:get/get.dart';

class V2SalesPerformanceDay extends StatelessWidget {
  V2SalesPerformanceDay({Key? key}) : super(key: key);
  final listChoose = ["Today", "This Month", "This Year"];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green[50],
      child: Column(
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
                SizedBox(
                  height: 300,
                  child: Card(
                    child: BarChart([
                      Series<V2MdlChart, String>(
                        id: "Sales",
                        data: [
                          V2MdlChart(
                              "Food",
                              V2Val.food.value.gtotal == null
                                  ? 0
                                  : int.parse(V2Val.food.value.gtotal.toString())),
                          V2MdlChart(
                              "Beverage",
                              V2Val.beverage.value.gtotal == null
                                  ? 0
                                  : int.parse(V2Val.beverage.value.gtotal.toString())),
                          V2MdlChart(
                              "Other",
                              V2Val.other.value.gtotal == null
                                  ? 0
                                  : int.parse(V2Val.other.value.gtotal.toString()))
                        ],
                        domainFn: (datum, index) => datum.name,
                        measureFn: (datum, index) => datum.nilai,
                        overlaySeries: true,
                        colorFn: (datum, index) => MaterialPalette.indigo.shadeDefault,
                        fillColorFn: (datum, index) => datum.name == "Food"
                            ? MaterialPalette.green.shadeDefault
                            : MaterialPalette.red.shadeDefault,
                      ),
                    ]),
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

class V2MdlChart {
  final String name;
  final int nilai;

  V2MdlChart(this.name, this.nilai);
}

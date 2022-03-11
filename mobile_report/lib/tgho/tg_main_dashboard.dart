import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:json_table/json_table.dart';
import 'package:mobile_report/tgho/tg_util_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

const jsonSample = [
  {"name": "Ram", "email": "ram@gmail.com", "age": 23, "DOB": "1990-12-01"},
  {
    "name": "Shyam",
    "email": "shyam23@gmail.com",
    "age": 18,
    "DOB": "1995-07-01"
  },
  {"name": "John", "email": "john@gmail.com", "age": 10, "DOB": "2000-02-24"},
  {"name": "Ram", "age": 12, "DOB": "2000-02-01"}
];

class TgMainDashboard extends StatelessWidget {
  const TgMainDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Obx(() => Container(
            color: Colors.blueGrey[50],
            padding: EdgeInsets.all(8),
            child: ListView(
              children: [
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Performance",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.blueGrey[700],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 32),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [loadBeverage(), loadFood(), loadOther()],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TgUtilVal.master['dept'].toString() == "null"
                                ? Center(
                                    child: Text("Loading ..."),
                                  )
                                : ExpansionTile(
                                    title: Text("Depatrtement"),
                                    children: [
                                      for (final d in TgUtilVal.master['dept'])
                                        CheckboxListTile(
                                          value: false,
                                          onChanged: (value) {},
                                          title: Text(
                                            d['nama_dept'].toString(),
                                          ),
                                        )
                                    ],
                                  ),
                          ),
                          Expanded(
                            child: TgUtilVal.master['out'].toString() == "null"
                                ? Center(
                                    child: Text("Loading ..."),
                                  )
                                : ExpansionTile(
                                    title: Text("Outlet"),
                                    children: [
                                      for (final d in TgUtilVal.master['out'])
                                        CheckboxListTile(
                                          value: false,
                                          onChanged: (value) {},
                                          title: Text(d['nama_out'].toString()),
                                        )
                                    ],
                                  ),
                          )
                        ],
                      ),
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text('Select Date'),
                        children: [
                          SfDateRangePicker(
                            showActionButtons: true,
                            allowViewNavigation: true,
                            enableMultiView: true,
                            toggleDaySelection: true,
                            showNavigationArrow: true,
                            showTodayButton: true,
                            onSubmit: (p0) {},
                            maxDate: DateTime.now(),
                            selectionMode:
                                DateRangePickerSelectionMode.extendableRange,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Total revenue",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.blueGrey[700],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            constraints:
                                BoxConstraints(maxWidth: 500, maxHeight: 300),
                            height: 300,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Rp 3000.0000.000",
                                    style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.blueGrey[700],
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: DChartBar(
                                    data: [
                                      {
                                        'id': 'Bar',
                                        'data': [
                                          {'domain': '2020', 'measure': 3},
                                          {'domain': '2021', 'measure': 4},
                                          {'domain': '2022', 'measure': 6},
                                          {'domain': '2023', 'measure': 0.3},
                                        ],
                                      },
                                    ],
                                    domainLabelPaddingToAxisLine: 16,
                                    axisLineTick: 2,
                                    axisLinePointTick: 2,
                                    axisLinePointWidth: 10,
                                    axisLineColor: Colors.green,
                                    measureLabelPaddingToAxisLine: 16,
                                    barColor: (barData, index, id) =>
                                        Colors.green,
                                    showBarValue: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            constraints:
                                BoxConstraints(maxWidth: 500, maxHeight: 300),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Rp 8000.0000.000",
                                    style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.blueGrey[700],
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: DChartBar(
                                    data: [
                                      {
                                        'id': 'Bar',
                                        'data': [
                                          {'domain': '2020', 'measure': 3},
                                          {'domain': '2021', 'measure': 4},
                                          {'domain': '2022', 'measure': 6},
                                          {'domain': '2023', 'measure': 0.3},
                                        ],
                                      },
                                    ],
                                    domainLabelPaddingToAxisLine: 16,
                                    axisLineTick: 2,
                                    axisLinePointTick: 2,
                                    axisLinePointWidth: 10,
                                    axisLineColor: Colors.green,
                                    measureLabelPaddingToAxisLine: 16,
                                    barColor: (barData, index, id) =>
                                        Colors.green,
                                    showBarValue: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Detail Summary",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.blueGrey[700],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 500,
                              maxHeight: 300,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Rp 4000.0000.000",
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.blueGrey[700],
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Flexible(
                                  child: DChartGauge(
                                    donutWidth: 200,
                                    data: [
                                      {'domain': 'Off', 'measure': 30},
                                      {'domain': 'Warm', 'measure': 30},
                                      {'domain': 'Hot', 'measure': 30},
                                    ],
                                    fillColor: (pieData, index) {
                                      switch (pieData['domain']) {
                                        case 'Off':
                                          return Colors.green;
                                        case 'Warm':
                                          return Colors.orange;
                                        default:
                                          return Colors.red;
                                      }
                                    },
                                    showLabelLine: false,
                                    pieLabel: (pieData, index) {
                                      return "${pieData['domain']}";
                                    },
                                    labelPosition: PieLabelPosition.inside,
                                    labelPadding: 0,
                                    labelColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 500,
                              maxHeight: 300,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Rp 4000.0000.000",
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.blueGrey[700],
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Flexible(
                                  child: EasyTable<Map<String, dynamic>>(
                                    EasyTableModel(
                                      rows: jsonSample,
                                      columns: [
                                        EasyTableColumn(
                                          name: "name",
                                          stringValue: (row) => row['name'],
                                          
                                        )
                                      ],
                                    ),
                                    columnsFit: true,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  loadBeverage() {
    var isi = "...";
    try {
      isi = TgUtilVal.dashboard['BEVERAGE']['_sum']['total'].toString();
      if (isi == "null") {
        isi = "0";
      }
    } catch (e) {
      print(e.toString());
    }
    return loadPanel("BEFERAGE", isi);
  }

  loadFood() {
    var isi = "...";
    try {
      isi = TgUtilVal.dashboard['FOOD']['_sum']['total'].toString();
      if (isi == "null") {
        isi = "0";
      }
    } catch (e) {
      print(e.toString());
    }
    return loadPanel("FOOD", isi);
  }

  loadOther() {
    var isi = "...";
    try {
      isi = TgUtilVal.dashboard['OTHERS']['_sum']['total'].toString();
      if (isi == "null") {
        isi = "0";
      }
    } catch (e) {
      print(e.toString());
    }
    return loadPanel("OTHERS", isi);
  }

  Widget loadPanel(String title, String value) => ResponsiveBuilder(
        builder: (context, sizingInformation) => Card(
          color: Colors.blueGrey[50],
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 500,
              minWidth: sizingInformation.isMobile ? 500 : 300,
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: DChartPie(
                    data: [
                      {
                        "domain": "satu",
                        "measure": 10,
                      },
                      {
                        "domain": "dua",
                        "measure": 50,
                      },
                      {
                        "domain": "tiga",
                        "measure": 1000,
                      },
                      {
                        "domain": "empat",
                        "measure": 40,
                      }
                    ],
                    fillColor: (data, i) => data['domain'] == 'satu'
                        ? Colors.red
                        : data['domain'] == 'dua'
                            ? Colors.green
                            : data['domain'] == 'tiga'
                                ? Colors.blueGrey
                                : Colors.yellow,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        value,
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

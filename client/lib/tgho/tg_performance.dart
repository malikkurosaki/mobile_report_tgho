import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile_report/tgho/tg_util_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'tg_util_pref.dart';

class TgPerformanceReport extends StatelessWidget {
  const TgPerformanceReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TgUtilPref.masterX['dept'].toString() == "null"
                      ? Center(
                          child: Text("Loading ..."),
                        )
                      : ExpansionTile(
                          title: Text("Depatrtement"),
                          children: [
                            for (final d in TgUtilPref.masterX['dept'])
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
                  child: TgUtilPref.masterX['out'].toString() == "null"
                      ? Center(
                          child: Text("Loading ..."),
                        )
                      : ExpansionTile(
                          title: Text("Outlet"),
                          children: [
                            for (final d in TgUtilPref.masterX['out'])
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
                  selectionMode: DateRangePickerSelectionMode.extendableRange,
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 32),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  loadBeverage(),
                  loadFood(),
                  loadOther(),
                ],
              ),
            ),
          ],
        ),
      ),
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
                  width: 300,
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        value,
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mobile_report/Val.dart';
import 'package:mobile_report/models.dart';
import 'package:mobile_report/pref.dart';
import 'package:mobile_report/util.dart';
import 'package:mobile_report/v2_error_log.dart';
import 'package:mobile_report/v2_models.dart';
import 'package:mobile_report/v2_pref.dart';
import 'package:mobile_report/v2_util.dart';
import 'package:mobile_report/v2_val.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:get/get.dart';

class V2DashboardOption extends StatelessWidget {
  final Color warna2 = Colors.cyan;
  final tangga1 = DateTime.now().obs;
  final tanggal2 = DateTime.now().obs;
  final calendarHeight = 350.0;
  final dep = V2ModelDep().obs;
  final out = V2ModelOut().obs;

  V2DashboardOption({Key? key}) : super(key: key);

  onLoad() async {
    EasyLoading.showInfo("load data ...");
    V2Util().loadMasterDep();
    V2Util().loadMasterOut();

    if (V2Val.dep.value.namaDept == null &&
        dep.value.namaDept == null &&
        V2Val.masterDep.isNotEmpty) {
      dep.value = V2Val.masterDep[0];
    }

    if (V2Val.out.value.kodeOut == null &&
        out.value.namaOut == null &&
        V2Val.masterOut.isNotEmpty) {
      out.value = V2Val.masterOut[0];
    }

    if (V2Val.out.value.kodeOut != null) {
      out.value = V2Val.out.value;
    }

    if (V2Val.dep.value.namaDept != null) {
      dep.value = V2Val.dep.value;
    }

    tangga1.value = V2Val.tanggal1.value;
    tanggal2.value = V2Val.tanggal2.value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          color: Colors.white,
          constraints: BoxConstraints(maxWidth: 500),
          child: Stack(
            children: [
              FutureBuilder(
                future: onLoad(),
                builder: (context, snapshot) => Text(""),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Align(alignment: Alignment.centerLeft, child: BackButton()),
                    Row(
                      children: [
                        Hero(
                          tag: "dat",
                          child: Icon(
                            Icons.date_range,
                            size: 42,
                            color: warna2,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Select Date",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      elevation: 0,
                      color: Colors.white,
                      child: SizedBox(
                        height: calendarHeight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SfDateRangePicker(
                                showTodayButton: true,
                                showNavigationArrow: true,
                                toggleDaySelection: true,
                                selectionColor: Colors.grey,
                                viewSpacing: 0,
                                headerHeight: 50,
                                navigationDirection:
                                    DateRangePickerNavigationDirection.vertical,
                                maxDate: DateTime.now(),
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                                initialDisplayDate: V2Val.tanggal1.value,
                                initialSelectedRange: PickerDateRange(
                                  V2Val.tanggal1.value,
                                  V2Val.tanggal2.value,
                                ),
                                onSelectionChanged:
                                    (DateRangePickerSelectionChangedArgs arg) {
                                  if (arg.value.startDate != null) {
                                    // V2Val.tanggal1.value = arg.value.startDate;
                                    tangga1.value = arg.value.startDate;
                                  }

                                  if (arg.value.endDate != null) {
                                    // V2Val.tanggal2.value = arg.value.endDate;
                                    tanggal2.value = arg.value.endDate;
                                  } else {
                                    tanggal2.value = arg.value.startDate;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                              tag: "out",
                              child: Icon(
                                Icons.store,
                                size: 42,
                                color: warna2,
                              )),
                        ),
                        Text(
                          "Select Departement",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Obx(
                        () => Wrap(
                          children: [
                            for (final mdep in V2Val.masterDep)
                              InkWell(
                                onTap: () => dep.value = mdep,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 0,
                                  color: mdep.namaDept == dep.value.namaDept
                                      ? Colors.blue
                                      : Colors.white,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      mdep.namaDept.toString(),
                                      style: TextStyle(
                                          color: mdep.namaDept ==
                                                  dep.value.namaDept
                                              ? Colors.white
                                              : Colors.grey[600],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                              tag: "dep",
                              child: Icon(
                                Icons.home_work_outlined,
                                size: 42,
                                color: warna2,
                              )),
                        ),
                        Text(
                          "Select Outlet",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Obx(
                        () => Wrap(
                          children: [
                            for (final mout in V2Val.masterOut)
                              InkWell(
                                onTap: () {
                                  out.value = mout;
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 0,
                                  color: mout.kodeOut == out.value.kodeOut
                                      ? Colors.blue
                                      : Colors.white,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      mout.namaOut.toString(),
                                      style: TextStyle(
                                          color:
                                              mout.kodeOut == out.value.kodeOut
                                                  ? Colors.white
                                                  : Colors.grey[600],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.yellow)),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("CANSEL")),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            onPressed: () async {
                              EasyLoading.showInfo("loading ...");
                              V2Val.tanggal1.value = tangga1.value;
                              V2Val.tanggal2.value = tanggal2.value;
                              V2Val.dep.value = dep.value;
                              V2Val.out.value = out.value;

                              V2Util().load();
                              Get.back();
                            },
                            child: Text(
                              "PROCCESS",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    // ErrorLog().log()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

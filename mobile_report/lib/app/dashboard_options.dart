import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_report/Val.dart';
import 'package:mobile_report/pref.dart';
import 'package:mobile_report/util.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:get/get.dart';

class DashboardOptions extends StatefulWidget {
  DashboardOptions({Key? key}) : super(key: key);

  @override
  State<DashboardOptions> createState() => _DashboardOptionsState();
}

class _DashboardOptionsState extends State<DashboardOptions> {
  final tglAwal = "".obs;

  final tglAkhir = "".obs;

  @override
  void initState() {
    iniData();
    super.initState();
  }

  iniData() async {
    EasyLoading.showInfo("loading ...", dismissOnTap: true);
    await Util().loadMasterDep();
    await Util().loadMasterOut();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Align(alignment: Alignment.centerLeft, child: BackButton()),
            Row(
              children: [
                Hero(
                  tag: "dat",
                  child: Icon(
                    Icons.date_range,
                    size: 42,
                    color: Colors.blue[700],
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
                height: 400,
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
                        selectionMode: DateRangePickerSelectionMode.range,
                        // initialDisplayDate:
                        //     DateTime.parse(Val.tgl1.value.toString()),
                        // initialSelectedRange: PickerDateRange(
                        //     DateTime.parse(Val.tgl1.value.toString()),
                        //     DateTime.parse(Val.tgl2.value.toString())),
                        onSelectionChanged:
                            (DateRangePickerSelectionChangedArgs arg) {
                          if (arg.value.startDate != null) {
                            tglAwal.value = arg.value.startDate.toString();
                          }

                          if (arg.value.endDate != null) {
                            tglAkhir.value = arg.value.endDate.toString();
                          }

                          if (tglAwal != "" && tglAkhir != "") {
                            // Val.tgl1.value = tglAwal.value;
                            // Val.tgl2.value = tglAkhir.value;
                          }
                        },
                      ),
                      // Obx(() => Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Val.tgl1.value.isEmpty
                      //             ? SizedBox.shrink()
                      //             : Expanded(
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child: Text("Start"),
                      //                     ),
                      //                     Card(
                      //                       color: Colors.blue,
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(8.0),
                      //                         child: Center(
                      //                           child: Text(
                      //                             Val.tgl1.value
                      //                                 .split(" ")[0]
                      //                                 .toString(),
                      //                             style: TextStyle(
                      //                                 color: Colors.white),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //         Val.tgl2.value.isEmpty
                      //             ? SizedBox.shrink()
                      //             : Expanded(
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child: Text("End"),
                      //                     ),
                      //                     Card(
                      //                       color: Colors.blue,
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(8.0),
                      //                         child: Center(
                      //                           child: Text(
                      //                             Val.tgl2.value
                      //                                 .split(" ")[0]
                      //                                 .toString(),
                      //                             style: TextStyle(
                      //                                 color: Colors.white),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               )
                      //       ],
                      //     )),
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
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Obx(
                () => Wrap(
                  children: [
                    for (final dep in Val.masterDep)
                      InkWell(
                        onTap: () => Val.dep.value = dep,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 0,
                          color: dep.namaDept == Val.dep.value.namaDept
                              ? Colors.blue
                              : Colors.white,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              dep.namaDept.toString(),
                              style: TextStyle(
                                  color: dep.namaDept == Val.dep.value.namaDept
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
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Obx(() => Wrap(
                    children: [
                      for (final out in Val.masterOut)
                        InkWell(
                          onTap: () {
                            Val.out.value = out;
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 0,
                            color: out.kodeOut == Val.out.value.kodeOut
                                ? Colors.blue
                                : Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                out.namaOut.toString(),
                                style: TextStyle(
                                    color: out.kodeOut == Val.out.value.kodeOut
                                        ? Colors.white
                                        : Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                    ],
                  )),
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
                        if (tglAwal.value.isNotEmpty) {
                          // set tanggal awal dan akhis state
                          // Val.tgl1.value = tglAwal.value;
                        }

                        if (tglAkhir.value.isNotEmpty) {
                          // Val.tgl2.value = tglAkhir.value;
                        }

                        // set tanggal awal dan akhir storage
                        Pref.dep().set(Val.dep.value);
                        Pref.out().set(Val.out.value);

                        Pref.tgl1().set(tglAwal.value);
                        Pref.tgl2().set(tglAkhir.value);

                        // load dashboard
                        await Util().loadDashboard();
                        Get.back();
                      },
                      child: Text(
                        "PROCCESS",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

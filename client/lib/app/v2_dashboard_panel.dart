import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_report/v2_val.dart';

import 'v2_dashboard_option.dart';

class V2DashboardPanel extends StatelessWidget {
  V2DashboardPanel({Key? key}) : super(key: key);
  final Color warna1 = Colors.grey.withOpacity(0.2);
  final Color warna2 = Colors.brown;
  final TextStyle style1 = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[700]);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: warna1,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                              tag: "dat",
                              child: Icon(Icons.date_range, color: warna2)),
                        ),
                        Expanded(
                            child: Text(
                          "Date",
                          style: TextStyle(color: warna2),
                        )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: V2Val.tanggal1.value == V2Val.tanggal2.value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DateFormat('dd/MM/yy')
                                  .format(V2Val.tanggal1.value),
                              style: style1,
                            ),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    DateFormat('d/MM/y')
                                        .format(V2Val.tanggal1.value),
                                    style: style1,
                                  ),
                                ),
                              ),
                              Text("To"),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    DateFormat('d/MM/y')
                                        .format(V2Val.tanggal2.value),
                                    style: style1,
                                  ),
                                ),
                              ),
                            ],
                          ))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: warna1,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                              tag: "out",
                              child: Icon(
                                Icons.store,
                                color: warna2,
                              )),
                        ),
                        Expanded(
                            child: Text(
                          "Outlet",
                          style: TextStyle(color: warna2),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        V2Val.out.value.namaOut ?? "All",
                        style: style1,
                      ),
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: warna1,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                              tag: "dep",
                              child: Icon(
                                Icons.home_work_outlined,
                                color: warna2,
                              )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Departement",
                              style: TextStyle(color: warna2),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            V2Val.dep.value.namaDept ?? "All",
                            style: style1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.to(V2DashboardOption(),
                              transition: Transition.noTransition,
                              duration: Duration(milliseconds: 500)),
                          child: Card(
                            margin: EdgeInsets.zero,
                            color: warna2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 8, right: 8),
                              child: Text(
                                "Custom",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

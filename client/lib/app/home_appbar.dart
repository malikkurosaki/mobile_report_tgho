import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_report/Val.dart';
import 'package:get/get.dart';
import 'package:mobile_report/app/dashboard_options.dart';
import 'package:mobile_report/app/home_tabbar.dart';
import 'package:mobile_report/app/profile.dart';
import 'package:mobile_report/util.dart';
import 'package:mobile_report/v2_test.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:mobile_report/ext.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);
  final tinggi = 350.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(238, 238, 238, 1),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bg_1.webp'))),
        child: Stack(
          children: [
            Container(
              color: Colors.black54,
              width: double.infinity,
              height: double.infinity,
            ),
            ListView(
              children: [
                
                SizedBox(
                  width: 270,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(Profile(),
                                            transition: Transition.noTransition, duration: Duration(milliseconds: 500));
                                      },
                                      child: Hero(
                                        tag: "profile",
                                        child: CircleAvatar(
                                            backgroundColor: Colors.green[700],
                                            child:
                                                Icon(Icons.account_circle_sharp, color: Colors.white,),),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Good Morning",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[700]),
                                          ),
                                          Text(
                                            "Nama User",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child:
                                            const Text("Date ").txtMenuBold()),
                                    // Expanded(
                                    //   flex: 2,
                                    //   child: Obx(
                                    //     () => Row(
                                    //       children: [
                                    //         Expanded(
                                    //           child: Text(
                                    //             DateFormat('dd-MM-yyyy').format(
                                    //               DateTime.parse(
                                    //                   Val.tgl1.value),
                                    //             ),
                                    //           ).txtMenu(),
                                    //         ),
                                    //         Expanded(
                                    //           child: Text(
                                    //             DateFormat("dd-MM-yyyy").format(
                                    //               DateTime.parse(
                                    //                   Val.tgl2.value),
                                    //             ),
                                    //           ).txtMenu(),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey[200],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text("Departement ").txtMenuBold(),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Obx(
                                        () => Text(Val.dep.value.namaDept
                                                .toString()
                                                .split(" ")[0])
                                            .txtMenu(),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey[200],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text("Outlet ").txtMenuBold(),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Obx(
                                        () => Text(
                                          Val.out.value.namaOut.toString(),
                                        ).txtMenu(),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey[200],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RawChip(
                                        
                                        selected: true,
                                        selectedColor: Colors.cyan[700],
                                        label: Text(
                                          "Month",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        avatar: Icon(
                                          Icons.date_range,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors.cyan[700],
                                      ),
                                    ),
                                    Expanded(
                                      child: RawChip(
                                        label: Text(
                                          "Year",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        avatar: Icon(
                                          Icons.date_range,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors.grey[700],
                                      ),
                                    ),
                                    Expanded(
                                      child: RawChip(
                                        onPressed: () async {
                                         
                                          Get.to(DashboardOptions(),
                                              transition: Transition.noTransition, duration: Duration(milliseconds: 500));
                                        },
                                        label: Text(
                                          "Custom",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        avatar: Hero(
                                          tag: "custom",
                                          child: Icon(
                                            Icons.date_range,
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: Colors.grey[700],
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     print("mont");
                                    //   },
                                    //   child: Card(
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(20)),
                                    //     color: Colors.cyan[700],
                                    //     child: Container(
                                    //       width: Get.width / 4,
                                    //       padding: EdgeInsets.all(8),
                                    //       child: Row(
                                    //         children: [
                                    //           Icon(Icons.date_range),
                                    //           Padding(
                                    //             padding: const EdgeInsets.only(left: 8),
                                    //             child: Text(
                                    //               "Month",
                                    //               style: TextStyle(
                                    //                   color: Colors.white),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     print("year");
                                    //   },
                                    //   child: Card(
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(20)),
                                    //     color: Colors.cyan[700],
                                    //     child: Container(
                                    //       width: Get.width / 4,
                                    //       padding: EdgeInsets.all(8),
                                    //       child: Center(
                                    //         child: Text(
                                    //           "Year",
                                    //           style: TextStyle(
                                    //               color: Colors.white),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // InkWell(
                                    //   onTap: () async {
                                    //     await Util().loadMasterDep();
                                    //     await Util().loadMasterOut();
                                    //     Get.to(DashboardOptions(),
                                    //         transition: Transition.downToUp);
                                    //   },
                                    //   child: Card(
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(20)),
                                    //     color: Colors.cyan[700],
                                    //     child: Container(
                                    //       width: Get.width / 4,
                                    //       padding: EdgeInsets.all(8),
                                    //       child: Center(
                                    //         child: Text(
                                    //           "custom",
                                    //           style: TextStyle(
                                    //               color: Colors.white),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.cyan[700],
                                        child: IconButton(
                                            onPressed: () {
                                              Util().loadDashboard();
                                            },
                                            icon: Icon(Icons.refresh)),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 8),
                                    //   child: CircleAvatar(
                                    //     backgroundColor: Colors.cyan[700],
                                    //     child: IconButton(
                                    //         onPressed: () async {

                                    //         },
                                    //         icon: Icon(Icons.arrow_drop_down)),
                                    //   ),
                                    // )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      expandedHeight: tinggi,
    );
  }
}

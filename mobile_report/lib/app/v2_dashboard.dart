import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_report/app/v2_dashboard_detail.dart';
import 'package:mobile_report/app/v2_detail_total_revenue.dart';
import 'package:mobile_report/pref.dart';
import 'package:mobile_report/v2_router.dart';
import 'package:mobile_report/v2_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'v2_dashboard_card.dart';
import 'v2_dashboard_panel.dart';

class V2Dashboard extends StatelessWidget {
  const V2Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (a, b) => Obx(
        () => Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey[800],
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Probus Report",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                 Container(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        V2Router.profile().go();
                      },
                      child: Icon(Icons.account_circle, size: 36,color: Colors.blue,)
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Visibility(
                    visible: !b.isMobile,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      width: Get.width * 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.account_circle, size: 53,color: Colors.blue,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Welcome, ${Pref.user().get()['name']}",
                                      style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              onTap: () {
                                
                              },
                              title: Text("DashBoard"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: ListView(
                              children: [
                                Visibility(
                                  visible: b.isMobile,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.account_box_sharp,
                                                size: 36,
                                              ),
                                              Text(Pref.user().get()['name'].toString().toUpperCase(),
                                                style: TextStyle(fontSize: 24,),
                                              )
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                V2DashboardPanel(),
                                V2DashboadItemCard(
                                  heroTag1: "food",
                                  bgColor: Colors.green,
                                  billValue:
                                      NumberFormat.simpleCurrency(locale: "id-ID")
                                          .format(V2Val.food.value.bill ?? 0),
                                  onDetail: () {
                                    Get.to(
                                        V2DashboardDetail(
                                          lsTop10: V2Val.top10Food,
                                          title: "Food",
                                          heroTag1: "food",
                                          icon1: Icons.restaurant,
                                          modelData: V2Val.food.value,
                                        ),
                                        transition: Transition.noTransition,
                                        duration:
                                            const Duration(milliseconds: 500));
                                  },
                                  title: "Food",
                                  value:
                                      NumberFormat.simpleCurrency(locale: "id-ID")
                                          .format(V2Val.food.value.gtotal == null
                                              ? 0
                                              : int.parse(V2Val.food.value.gtotal
                                                  .toString())),
                                  titleIcon: Icons.restaurant,
                                ),
                                V2DashboadItemCard(
                                  heroTag1: "beverage",
                                  bgColor: Colors.red,
                                  billValue: NumberFormat.simpleCurrency(
                                          locale: "id-ID")
                                      .format(V2Val.beverage.value.bill == null
                                          ? 0
                                          : int.parse(V2Val.beverage.value.bill
                                              .toString())),
                                  onDetail: () {
                                    Get.to(
                                        V2DashboardDetail(
                                          lsTop10: V2Val.top10Beverage,
                                          title: "Beverage",
                                          heroTag1: "beverage",
                                          icon1: Icons.coffee,
                                          modelData: V2Val.beverage.value,
                                        ),
                                        transition: Transition.noTransition,
                                        duration: Duration(milliseconds: 500));
                                  },
                                  title: "Beverage",
                                  value: NumberFormat.simpleCurrency(
                                          locale: "id-ID")
                                      .format(V2Val.beverage.value.gtotal == null
                                          ? 0
                                          : int.parse(V2Val.beverage.value.gtotal
                                              .toString())),
                                  titleIcon: Icons.coffee,
                                ),
                                V2DashboadItemCard(
                                  heroTag1: "other",
                                  bgColor: Colors.orange,
                                  billValue: NumberFormat.simpleCurrency(
                                          locale: "id-ID")
                                      .format(V2Val.other.value.bill == null
                                          ? 0
                                          : int.parse(
                                              V2Val.other.value.bill.toString())),
                                  onDetail: () {
                                    Get.to(
                                        V2DashboardDetail(
                                          lsTop10: V2Val.top10Other,
                                          modelData: V2Val.other.value,
                                          title: "Other",
                                          heroTag1: "other",
                                          icon1: Icons.fastfood,
                                        ),
                                        transition: Transition.noTransition,
                                        duration: Duration(milliseconds: 500));
                                  },
                                  title: "Others",
                                  value:
                                      NumberFormat.simpleCurrency(locale: "id-ID")
                                          .format(V2Val.other.value.gtotal == null
                                              ? 0
                                              : int.parse(V2Val.other.value.gtotal
                                                  .toString())),
                                  titleIcon: Icons.fastfood,
                                ),
                                InkWell(
                                  onTap: () => Get.to(V2DetailTotalRevenue()),
                                  child: Card(
                                    color: Colors.cyan,
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white54),
                                          ),
                                          Text(
                                            "Revenue",
                                            style: TextStyle(
                                                fontSize: 42,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white54),
                                          ),
                                          Text(
                                            NumberFormat.simpleCurrency(
                                                    locale: "id-ID")
                                                .format(V2Val.totalRevenue.value
                                                            .gtotal ==
                                                        null
                                                    ? 0
                                                    : int.parse(V2Val
                                                        .totalRevenue.value.gtotal
                                                        .toString())),
                                            style: TextStyle(
                                                fontSize: 42,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: b.isDesktop,
                          child: SizedBox(
                            width: Get.width * 0.2,
                            child: Column(
                              children: [Text("Side")],
                            ),
                          ),
                        )
                      ],
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

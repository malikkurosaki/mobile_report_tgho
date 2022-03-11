import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:mobile_report/Val.dart';
import 'package:mobile_report/app/home.dart';
import 'package:mobile_report/conn.dart';
import 'package:mobile_report/models.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Val.listDashboard.isEmpty
          ? Center(child: Text("Data empty"))
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                for (final p in Val.listDashboard) kotakBox(p),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text("Total Revenue",
                                  style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Val.totalRevenue.value.gross.toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("Gross"),
                                      Divider(),
                                      Text(
                                          Val.totalRevenue.value.net.toString(),
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold)),
                                      Text("Net"),
                                      Divider(),
                                      Text(
                                          Val.totalRevenue.value.total
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold)),
                                      Text("Total"),
                                      Divider(),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Text(
                                              Val.totalRevenue.value.bill
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 32,
                                                  color: Colors.cyan,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            "Total Pax",
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Text(
                                              Val.totalRevenue.value.pax
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 32,
                                                  color: Colors.cyan,
                                                  fontWeight: FontWeight.bold)),
                                          Text("Total Bill"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text("Avarage Bill / Pax",
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Val.totalRevenue.value.gross.toString(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Gross"),
                                    Divider(),
                                    Text(Val.averageBillPax.value.net.toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold)),
                                    Text("Net"),
                                    Divider(),
                                    Text(
                                        Val.averageBillPax.value.total.toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold)),
                                    Text("Total"),
                                    Divider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text("Compliment Gross",
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Val.complimentGross.value.food.toString(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Food"),
                                    Divider(),
                                    Text(Val.complimentGross.value.beverage.toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold)),
                                    Text("Beverage"),
                                    Divider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
    );
  }

  Widget kotakBox(ModelDashboardV2 p) => Padding(
        padding: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/splash.png'))),
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  color: p.name == "food"
                      ? Colors.green.withOpacity(0.9)
                      : p.name == "beverage"
                          ? Colors.red.withOpacity(0.9)
                          : Colors.orange.withOpacity(0.9),
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.name.toString().toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Text(
                                      p.data!.sSum!.net == null
                                          ? "Rp 0,-"
                                          : NumberFormat.simpleCurrency(
                                                  locale: 'id-Id')
                                              .format(int.parse(p
                                                  .data!.sSum!.net!
                                                  .toString())),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Rp 20.000",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "This Mont",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Rp 200.000",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "This Year",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Text(
                        p.data!.sSum!.gtotal == null
                            ? "Rp 0,-"
                            : NumberFormat.simpleCurrency(locale: "id-ID")
                                .format(int.parse(
                                    p.data!.sSum!.gtotal!.toString())),
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

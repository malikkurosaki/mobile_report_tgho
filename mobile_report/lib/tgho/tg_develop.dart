import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_connect.dart';
import 'package:mobile_report/tgho/tg_conn.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TgDevelop extends StatelessWidget {
  const TgDevelop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Material(
        child: SafeArea(
          child: Column(
            children: [
              Text("Develop"),
              Flexible(
                  child: SingleChildScrollView(
                      child: Wrap(
                children: [
                  layout("Year Report", TgConn().getYearReport()),
                  layout("Dept", TgConn().getDeptReport()),
                  layout("Product", TgConn().getProductReportYear())
                ],
              )))
            ],
          ),
        ),
      ),
    );
  }

  Widget layout(String title, Future<Response> future) => SizedBox(
        width: 300,
        child: Card(
          child: ExpansionTile(
            title: Text(title),
            children: [
              FutureBuilder<Response>(
                future: future,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.done
                        ? SingleChildScrollView(
                            child: Text(JsonEncoder.withIndent("\t\t")
                                .convert(snapshot.data!.body)))
                        : Text("Loading..."),
              )
            ],
          ),
        ),
      );
}

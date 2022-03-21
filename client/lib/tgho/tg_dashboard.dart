import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mobile_report/tgho/tg_conn.dart';
import 'package:mobile_report/tgho/tg_main_dashboard.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';
import 'package:mobile_report/tgho/tg_revenue.dart';
import 'package:mobile_report/tgho/tg_sidebar.dart';
import 'package:mobile_report/tgho/tg_util_gval.dart';
import 'package:mobile_report/tgho/tg_util_load.dart';
import 'package:mobile_report/tgho/tg_util_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

final listMenuBarItem = [
  "Home",
  "About",
  "Product",
  "Contact",
  "Dukungan",
  "Bisnis",
];

class TgDashboard extends StatelessWidget {
  const TgDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: !sizingInformation.isMobile,
                child: Container(
                  color: Colors.blueGrey[800],
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Tg HO",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey[50]),
                            ),
                          ],
                        ),
                      ),
                      
                      Wrap(
                        children: [
                          for (final menu in listMenuBarItem)
                            TextButton(
                              onPressed: () {
                                EasyLoading.showToast("coming soon");
                              },
                              child: Text(
                                menu.toString(),
                              ),
                            )
                        ],
                      ),
                      RawChip(
                        avatar: Icon(Icons.language),
                        label: Text("English"),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: sizingInformation.isMobile,
                child: Container(
                  color: Colors.grey[900],
                  padding: const EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          Get.bottomSheet(
                              DraggableScrollableSheet(
                                builder: (context, scrollController) => Material(
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: TgSidebar(),
                                  ),
                                ),
                              ),
                              isScrollControlled: true,
                              isDismissible: true);
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Dashboard",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[200],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: sizingInformation.isDesktop,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: sizingInformation.screenSize.width * 0.2,
                        ),
                        child: TgSidebar(),
                      ),
                    ),
                    Expanded(child: TgMainDashboard())
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onLoad() async {
   
  }
}



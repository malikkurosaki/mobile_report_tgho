import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mobile_report/tgho/tg_conn.dart';
import 'package:mobile_report/tgho/tg_main_dashboard.dart';
import 'package:mobile_report/tgho/tg_sidebar.dart';
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
  "Solusi",
  "Karir",
  "Perusahaan",
  "Service",
  "Login"
];

class TgDashboard extends StatelessWidget {
  const TgDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onLoad();
    return Material(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // mobile app bar
            Visibility(
              visible: sizingInformation.isDesktop,
              child: Container(
                color: Colors.blueGrey[800],
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Dashboard",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[50]),
                      ),
                    ),
                    Wrap(
                      children: [
                        for (final menu in listMenuBarItem)
                          TextButton(
                              onPressed: () {}, child: Text(menu.toString()))
                      ],
                    ),
                    RawChip(
                        avatar: Icon(Icons.language),
                        label: Text("English"),
                        onPressed: () {})
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
                                builder: (context, scrollController) =>
                                    Material(
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
                                color: Colors.blueGrey[200]),
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
                )),
            Expanded(
              child: Row(
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
    );
  }

  onLoad() async {
    try {
      EasyLoading.show(dismissOnTap: true);
      final data =
          await TgConn().getDashboard("2022-02-10", "2022-03-01", "all", "all");
      // print(data.body);
      EasyLoading.dismiss();

      TgUtilVal.dashboard.assignAll(data.body['data']);
      TgUtilVal.master.assignAll(data.body['master']);
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }

   
  }
}

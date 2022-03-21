import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class V2BottomNav extends StatelessWidget {
  V2BottomNav({Key? key}) : super(key: key);

  final listTab = <MyNavItem>[
    MyNavItem(title: "Dashboard", icon: Icons.dashboard),
    MyNavItem(title: "Sales Performance day", icon: Icons.add_chart_sharp),
    MyNavItem(title: "Sales Performance week", icon: Icons.dashboard),
    MyNavItem(title: "Sales Performance Month", icon: Icons.dashboard)
  ];

  @override
  Widget build(BuildContext context) {
    return TabBar(
      overlayColor: MaterialStateProperty.all(Colors.grey),
      isScrollable: true,
      indicatorWeight: 0.1,
      unselectedLabelColor: Colors.grey,
      padding: EdgeInsets.zero,
      labelColor: Colors.blue,
      indicatorColor: Colors.transparent,
      tabs: [
        for (final tb in listTab)
        Tab(
          icon: Icon(tb.icon),
          text: tb.title,
        )
          // Tab(
          //   child: Container(
          //     padding: EdgeInsets.all(8),
          //     width: Get.width / 3,
          //     color: Colors.grey[800],
          //     child: Row(
          //       children: [
          //         Icon(tb.icon),
          //         Expanded(
          //           child: Container(
          //             padding: EdgeInsets.all(8),
          //             child: Text(
          //               tb.title.toString(),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )
      ],
    );
  }
}

class MyNavItem {
  String? title;
  IconData? icon;
  MyNavItem({this.title, this.icon});
}

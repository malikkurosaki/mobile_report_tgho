import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_report/Val.dart';

class HomeTabbar extends StatelessWidget {
  HomeTabbar({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: BoxDecoration(
        color: Colors.transparent
      ),
      unselectedLabelColor: Colors.grey,
      enableFeedback: true,
      labelColor: Colors.grey[800],
      isScrollable: true,
      automaticIndicatorColorAdjustment: true,
      labelPadding: EdgeInsets.zero,
      labelStyle: TextStyle(
        fontSize: 18
      ),
      tabs: [
        for (final t in Val.listTab)
          Container(
            width: Get.width / 3,
            color: Colors.grey[100],
            child: Tab(
              text: t,
            ),
          )
      ],
    );
  }
}

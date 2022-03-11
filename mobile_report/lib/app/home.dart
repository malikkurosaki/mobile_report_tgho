import 'package:flutter/material.dart';
import 'package:mobile_report/Val.dart';
import 'package:mobile_report/app/dashboard.dart';
import 'package:mobile_report/app/home_appbar.dart';
import 'package:mobile_report/app/home_tabbar.dart';
import 'package:mobile_report/app/view_sales_avarage.dart';
import 'package:mobile_report/app/view_sales_performance.dart';
import 'package:mobile_report/config.dart';
import 'package:mobile_report/util.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    print(Config.getUrl);
    Util().init();
    Util().loadDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Val.listTab.length,
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        bottomNavigationBar: HomeTabbar(),
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            HomeAppBar(),
          ],
          body: TabBarView(
            children: [
              Dashboard(),
              ViewSalesPerformance(
                animate: true,
              ),
              ViewSalesAvarage(
                animate: true,
              ),
              Text("Empat")
            ],
          ),
        ),
      ),
    );
  }

//   InkWell(
//   onTap: () {
//     Get.bottomSheet(
//       DraggableScrollableSheet(
//         builder: (context, scrollController) => Card(
//           child: Container(
//             padding: EdgeInsets.all(16),
//             child: ListView(
//               controller: scrollController,
//               children: [Text("hahah ini ada diamana")],
//             ),
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//       isDismissible: true,
//     );
//   },
//   child: Card(
//     color: Colors.blue,
//     child: Container(
//       width: Get.width,
//       padding: EdgeInsets.all(8),
//       child: Obx(() => Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                             child: Text(
//                           "Tanggal",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         )),
//                         Expanded(
//                             child: Text("Departement",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white))),
//                         Expanded(
//                             child: Text("Outlet",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white))),
//                       ],
//                     ),
//                     Divider(),
//                     Flexible(
//                       child: Row(
//                         children: [
//                           Expanded(
//                               child: Text(
//                             Val.tgl.value
//                                 .toString()
//                                 .split(" ")[0]
//                                 .toString(),
//                             style:
//                                 TextStyle(color: Colors.white54),
//                           )),
//                           Expanded(
//                               child: Text(
//                             Val.dep.value,
//                             style:
//                                 TextStyle(color: Colors.white54),
//                           )),
//                           Expanded(
//                               child: Text(
//                             Val.out.value,
//                             style:
//                                 TextStyle(color: Colors.white54),
//                           )),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(Icons.arrow_drop_down)
//             ],
//           )),
//     ),
//   ),
// )

  // Future<void> onLoad() async {
  //   final dash = await Conn().dashBoard("2021-01-01", "", "");
  //   Val.dashboard.value = ModelDashboard.fromJson(dash.body);
  // }

  Drawer drawer() => Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [Text("drawer header")],
              ),
            )
          ],
        ),
      );
}

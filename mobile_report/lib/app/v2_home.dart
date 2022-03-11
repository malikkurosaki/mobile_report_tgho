// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mobile_report/app/profile.dart';
// import 'package:mobile_report/app/v2_bottom_nav.dart';
// import 'package:mobile_report/app/v2_sales_performance_day.dart';
// import 'package:mobile_report/app/v2_dashboard.dart';
// import 'package:get/get.dart';
// import 'package:mobile_report/app/v2_profile.dart';
// import 'package:mobile_report/app/v2_sales_performance_month.dart';
// import 'package:mobile_report/app/v2_sales_performance_week.dart';
// import 'package:mobile_report/pref.dart';
// import 'package:mobile_report/util.dart';
// import 'package:mobile_report/v2_conn.dart';
// import 'package:mobile_report/v2_models.dart';
// import 'package:mobile_report/v2_pref.dart';
// import 'package:mobile_report/v2_util.dart';
// import 'package:mobile_report/v2_val.dart';

// class V2Home extends StatefulWidget {
//   const V2Home({Key? key}) : super(key: key);

//   @override
//   _V2HomeState createState() => _V2HomeState();
// }

// class _V2HomeState extends State<V2Home> {
//   final tinggi = 200.0;

//   @override
//   void initState() {
//     V2Val.user.value = V2ModelUser.fromJson(V2Pref.user().get());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         bottomNavigationBar: V2BottomNav(),
//         body: NestedScrollView(
//           physics: BouncingScrollPhysics(),
//           headerSliverBuilder: (context, innerBoxIsScrolled) => [
//             SliverAppBar(
//               backgroundColor: Colors.black54,
//               snap: true,
//               floating: true,
//               elevation: 0,
//               expandedHeight: tinggi,
//               flexibleSpace: Container(
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/bg_1.webp'),
//                         fit: BoxFit.cover)),
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: Get.width,
//                       height: double.infinity,
//                       color: Colors.black54,
//                     ),
//                     SingleChildScrollView(
//                       physics: BouncingScrollPhysics(),
//                       child: SizedBox(
//                         width: Get.width,
//                         height: tinggi,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Card(
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Hero(
//                                             tag: "profile",
//                                             child: InkWell(
//                                               onTap: () => Get.to(V2Profile(),
//                                                   transition:
//                                                       Transition.noTransition,
//                                                   duration: Duration(
//                                                       milliseconds: 500)),
//                                               child: Icon(
//                                                 Icons.account_circle,
//                                                 size: 56,
//                                                 color: Colors.green,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: InkWell(
//                                             onTap: () {
//                                               Get.dialog(AlertDialog(
//                                                 content: Text(V2Pref.user()
//                                                     .get()
//                                                     .toString()),
//                                               ));
//                                             },
//                                             child: Text(
//                                               V2Val.user.value.name.toString(),
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                   fontSize: 24,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.grey[700]),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       const Align(
//                                         alignment: Alignment.topRight,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             "Esquina",
//                                             style: TextStyle(fontSize: 24),
//                                           ),
//                                         ),
//                                       ),
//                                       Align(
//                                         alignment: Alignment.bottomRight,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(DateFormat('dd/mm/yyyy')
//                                               .format(DateTime.now())),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//           body: TabBarView(
//             children: [
//               const V2Dashboard(),
//               V2SalesPerformanceDay(),
//               const V2SalesPerformanceWeek(),
//               const V2SalesPerformanceMonth()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile_report/app/v2_dashboard.dart';
import 'package:mobile_report/pref.dart';
import 'package:mobile_report/v2_conn.dart';
import 'package:mobile_report/v2_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class V2Home extends StatelessWidget {
  const V2Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onLoad();
    return V2Dashboard();
  }

  onLoad()async{
    
  }
}

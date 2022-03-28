// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/instance_manager.dart';
// import 'package:get/get.dart';
// import 'package:mobile_report/Val.dart';
// import 'package:mobile_report/v2_router.dart';
// import 'package:mobile_report/splash.dart';

// import 'pref.dart';

// class Intro extends StatelessWidget {
//   Intro({Key? key}) : super(key: key);
//   final PageController controller = PageController();
//   final pageIndex = 0.obs;
//   final listIntro = [
//     IntroItem(
//       title: "Total Bill",
//       subTitle:
//           "You keep track of your business through restaurant analytics. Restaurant mobile analytic can give specific billing details for each outlet",
//       bgColor: Colors.blue[700],
//       image: "https://i.postimg.cc/k5jBXRP5/image.png",
//     ),
//     IntroItem(
//       title: "Items Sold Count",
//       subTitle:
//           "Restaurant mobile analytic app is integrated with the POS which gives the total number of total items that have been sold in that day.",
//       bgColor: Colors.green[700],
//       image: "https://i.postimg.cc/W1hz3bSp/image.png",
//     ),
//     IntroItem(
//       title: "Total Sale Details",
//       subTitle:
//           "The entire sales data is available for your use and can be seen on the basis of day, week, month, or annual. You can view the net sales, gross sales, the total number of bills generated,",
//       bgColor: Colors.red[700],
//       image: "https://i.postimg.cc/0j0MpWJ8/image.png",
//     )
//   ].obs;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.blueGrey[200],
//       child: Center(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(maxWidth: 500),
//           child: Column(
//             children: [
//               Flexible(
//                 child: PageView(
//                   onPageChanged: (value) => pageIndex.value = value,
//                   controller: controller,
//                   children: [
//                     for (final a in listIntro)
//                       Stack(
//                         children: [
//                           Container(
//                             color: a.bgColor,
//                             child: Center(
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Image.network(
//                                     a.image!,
//                                     width: 200,
//                                     fit: BoxFit.contain,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       a.title!,
//                                       style: TextStyle(
//                                           fontSize: 40,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(32),
//                                     child: Text(
//                                       a.subTitle!,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       )
//                   ],
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 child: Container(
//                   padding: EdgeInsets.all(16),
//                   color: Colors.blueGrey[800],
//                   width: Get.width,
//                   child: Obx(
//                     () => Row(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Expanded(
//                           child: Row(
//                             children: [
//                               for (final a in List.generate(
//                                   listIntro.length, (index) => index))
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     color: pageIndex.value == a
//                                         ? Colors.white
//                                         : Colors.grey,
//                                   ),
//                                   margin: EdgeInsets.all(2),
//                                   padding: EdgeInsets.all(4),
//                                   width: 40,
//                                   height: 5,
//                                 )
//                             ],
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Pref.isIntro().set(false);
//                             V2Router.root().goOff();
//                           },
//                           child: Text(
//                             "NEXT",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> onLoad() async {}
// }

// class IntroItem {
//   String? title;
//   String? subTitle;
//   String? image;
//   Color? bgColor;
//   IconData? icon;

//   IntroItem({this.title, this.subTitle, this.image, this.bgColor, this.icon});
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/instance_manager.dart';
// import 'package:get/get.dart';
// import 'package:mobile_report/Val.dart';
// import 'package:mobile_report/splash.dart';
// import 'package:mobile_report/v2_pref.dart';
// import 'package:mobile_report/v2_splash.dart';
// import 'package:mobile_report/v2_val.dart';

// import 'pref.dart';

// class V2Intro extends StatelessWidget {
//   V2Intro({Key? key}) : super(key: key);
//   final controller = PageController();
//   final pageIndex = 0.obs;

//   final listIntro = [
//     V2IntroItem(
//         title: "Judul Satu",
//         subTitle: "sub title",
//         bgColor: Colors.blue,
//         icon: Icons.note_alt_outlined),
//     V2IntroItem(
//         title: "Judul dua",
//         subTitle: "sub dua",
//         bgColor: Colors.green,
//         icon: Icons.add_chart_outlined),
//     V2IntroItem(
//         title: "Judul tiga",
//         subTitle: "sub tiga",
//         bgColor: Colors.red[800],
//         icon: Icons.money)
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Stack(
//         children: [
//           FutureBuilder(
//             future: onLoad(),
//             builder: (context, snapshot) => Text(""),
//           ),
//           PageView(
//             onPageChanged: (value) => pageIndex.value = value,
//             controller: controller,
//             children: [
//               for (final a in listIntro)
//                 Stack(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [a.bgColor!, Colors.black])),
//                       child: Center(
//                         child: Icon(
//                           a.icon,
//                           size: 120,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         bottom: 100,
//                         right: 0,
//                         left: 0,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               a.title.toString(),
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 24),
//                             ),
//                             Text(
//                               a.subTitle.toString(),
//                               style: TextStyle(color: Colors.grey[200]),
//                             )
//                           ],
//                         ))
//                   ],
//                 )
//             ],
//           ),
//           Positioned(
//             bottom: 0,
//             child: Container(
//               padding: EdgeInsets.all(8),
//               height: 70,
//               width: Get.width,
//               child: Obx(
//                 () => Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                         child: Row(
//                       children: [
//                         for (final a in List.generate(
//                             listIntro.length, (index) => index))
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: pageIndex.value == a
//                                   ? Colors.white
//                                   : Colors.grey,
//                             ),
//                             margin: EdgeInsets.all(2),
//                             padding: EdgeInsets.all(4),
//                             width: 30,
//                             height: 5,
//                           )
//                       ],
//                     )),
//                     pageIndex.value == (listIntro.length - 1)
//                         ? TextButton(
//                             onPressed: () {
//                               V2Val.isIntro.value = false;
//                               V2Pref.isIntro().set(false);
//                               Get.offAll(V2Splash());
//                             },
//                             child: Text(
//                               "NEXT",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           )
//                         : Text("")
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> onLoad() async {}
// }

// class V2IntroItem {
//   String? title;
//   String? subTitle;
//   String? image;
//   IconData? icon;
//   Color? bgColor;

//   V2IntroItem({this.title, this.subTitle, this.image, this.bgColor, this.icon});
// }

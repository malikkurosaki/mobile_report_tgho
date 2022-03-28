// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobile_report/pref.dart';
// import 'v2_router.dart';
// import 'v2_val.dart';

// class V2Root extends StatelessWidget {
//   const V2Root({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     onLoad();
//     return const Material(
//       child: Center(
//         child: Text('loading ...'),
//       ),
//     );
//   }

//   onLoad() async {
//     await 0.1.delay();
//     if (Pref.isIntro().get() ?? true) {
//       V2Router.intro().goOff();
//       return;
//     }

//     if (!Pref.user().has()) {
//       V2Router.login().goOff();
//       return;
//     }

//     // V2Router.home().goOff();
//     V2Router.dashboard().goOff();
//   }
// }

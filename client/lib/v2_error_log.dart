import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobile_report/v2_val.dart';
import 'package:get/get.dart';

class ErrorLog{

  String key = "errorLog";
  String id = "";

  create(String text, String e){

    List<Map<String, dynamic>> lsLog;
    final data = GetStorage().read(key);


    if(data == null){
      lsLog = <Map<String, dynamic>>[];
    }else{
      lsLog = List.from(data);
    }

    id = (Random().nextInt(100000000) + 1000000).toString();
    final modelError = {
      "time": DateTime.now().toString(),
      "text": text,
      "message": e.toString(),
      "id": id
    };

    lsLog.add(modelError);
    GetStorage().write(key, lsLog);
    EasyLoading.showToast("errr: "+ id);

    print(modelError);
    return id;
  }

  List<Map<String, dynamic>> val() {
    if(GetStorage().hasData(key)){
      final data = GetStorage().read(key);
      return List<Map<String, dynamic>>.from(data);
    }else{
      return <Map<String, dynamic>>[];
    }
  }

  clear() {
    GetStorage().remove(key);
    V2Val.config.value.isDebug = false;
  }

    // Widget log() => Obx(
    //     () => Visibility(
    //       visible: V2Val.config.value.isDebug!,
    //       child: Column(
    //         children: [
    //           TextButton(
    //               onPressed: () {
    //                 ErrorLog().clear();
    //               },
    //               child: Text("CLEAR")),
    //           for (final el in ErrorLog().val().reversed)
    //             Card(
    //               color: Colors.black,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       el['id'].toString(),
    //                       style: TextStyle(color: Colors.yellow),
    //                     ),
    //                     Text(
    //                       DateFormat('h:m:s')
    //                           .format(DateTime.parse(el['time'])),
    //                       style: TextStyle(color: Colors.yellow),
    //                     ),
    //                     Text(
    //                       el['text'],
    //                       style: TextStyle(color: Colors.yellow),
    //                     ),
    //                     Divider(),
    //                     Text(
    //                       el['message'],
    //                       style: TextStyle(color: Colors.yellow),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             )
    //         ],
    //       ),
    //     ),
    //   );

}
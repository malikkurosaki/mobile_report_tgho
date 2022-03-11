import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_report/v2_error_log.dart';
import 'package:mobile_report/v2_models.dart';
import 'package:mobile_report/v2_val.dart';
import 'package:get/get.dart';

class V2Pref <T>{
  String key = "";
  V2Pref.user() : key = "user";
  V2Pref.dep() : key = "dep";
  V2Pref.out() : key = "out";
  V2Pref.tanggal1() : key = "tanggal1";
  V2Pref.tanggal2() : key = "tanggal2";
  V2Pref.food() : key = "food";
  V2Pref.masterDep() : key = "masterDep";
  V2Pref.masterOut() : key = "masterOut";
  V2Pref.config() : key = "config";
  V2Pref.isIntro() : key = 'isIntro';

  get() {
    final value = GetStorage().read(key);
    return value;
  }

  T val(T t){
    return t;
  }

  set(T value) {
    if (value != null) {
      GetStorage().write(key, value);
    }
  }

  has() => GetStorage().hasData(key);
  del() => GetStorage().remove(key);

  V2Pref.init() {
    if (!V2Pref.dep().has()) {
      V2Pref.dep().set(V2ModelDep(namaDept: "All", unitBisnis: "All").toJson());
    }

    if (!V2Pref.out().has()) {
      V2Pref.out().set(V2Pref.out()
          .set(V2ModelOut(kodeOut: "All", namaOut: "All").toJson()));
    }

    if (!V2Pref.tanggal1().has()) {
      V2Pref.tanggal1().set(DateTime.now().toString());
    }

    if (!V2Pref.tanggal2().has()) {
      V2Pref.tanggal2().set(DateTime.now().toString());
    }

    if (!V2Pref.food().has()) {
      final mdlFood = V2ModelFood(
          bill: 0,
          compliLength: 0,
          compliTotal: 0,
          gtotal: 0,
          net: 0,
          total: 0);

      V2Pref.food().set(mdlFood.toJson());
    }

    if (!V2Pref.masterDep().has()) {
      final mdl = V2ModelDep(namaDept: "All", unitBisnis: "All");
      V2Pref.masterDep().set(mdl.toJson());
    }

    if (!V2Pref.masterOut().has()) {
      final mdl = V2ModelOut(kodeOut: "All", namaOut: "All");
      V2Pref.masterOut().set(mdl.toJson());
    }
  }

  V2Pref.clear() {
    GetStorage().erase();
  }


}


class Ambil<T>{
  T data(T t) => t;
}

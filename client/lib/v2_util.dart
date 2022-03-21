import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mobile_report/models.dart';
import 'package:mobile_report/v2_router.dart';
import 'package:mobile_report/v2_conn.dart';
import 'package:mobile_report/v2_models.dart';
import 'package:mobile_report/v2_pref.dart';
import 'package:mobile_report/v2_splash.dart';
import 'package:mobile_report/v2_val.dart';
import 'v2_error_log.dart';

class V2Util {
  V2Util();

  V2Util.init() {
    load();
  }

  load() async {
    EasyLoading.showInfo("load data ..");
    // await loadMasterDep();
    // await loadMasterOut();
    await loadFood();
    await loadBeverage();
    await loadOther();
    await loadToalRevenue();
    await loadSalesPerformanceWeek();
    await loadSalesPerformanceMonth();
  }

  Future loadFood() async {
    try {
      final res = await V2Conn().getFood();
      V2Val.food.value = V2ModelFood.fromJson(res.body);

      print(V2Val.tanggal1.value);
      print(V2Val.tanggal2.value);

    } catch (e) {
      ErrorLog().create("V2Util:laodFood", e.toString());
    }
  }

  Future loadBeverage() async {
    try {
      final res = await V2Conn().beverage();
      V2Val.beverage.value = V2ModelFood.fromJson(res.body);

      // print(res.body);
    } catch (e) {
      ErrorLog().create("V2Util:laodFood", e.toString());
    }
  }

  Future loadOther() async {
    try {
      final res = await V2Conn().other();
      V2Val.other.value = V2ModelFood.fromJson(res.body);

      // print(res.body);
    } catch (e) {
      ErrorLog().create("V2Util:laodFood", e.toString());
    }
  }

  Future<void> loadMasterDep() async {
    try {
      final res = await V2Conn().masterDep();
      final data = List.from(res.body).map((e) => V2ModelDep.fromJson(e));
      V2Val.masterDep.assignAll(data);
    } catch (e) {
      EasyLoading.showError("V2Uti:loadMasterDep");
    }
  }

  Future<void> loadMasterOut() async {
    try {
      final res = await V2Conn().masterOut();
      final data =
          List.from(res.body).map((e) => V2ModelOut.fromJson(e)).toList();
      V2Val.masterOut.assignAll(data);
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  Future login(Map<String, dynamic> body) async {

    try {
      final data = await V2Conn().login(body);

      if (data.body['success']) {
        V2Pref.user().set(data.body['data']);
        V2Router.root().goOff();
      } else {
        EasyLoading.showError(data.body['message']);
      }
    } catch (e) {
      ErrorLog().create("V2util:login", e.toString());
    }
  }

  Future? updateOption(
      {required DateTime tanggal1,
      required DateTime tanggal2,
      required V2ModelDep dep,
      required V2ModelOut out}) {}

  Future loadToalRevenue() async {
    try {
      final data = await V2Conn().totalRevenue();
      V2Val.totalRevenue.value = V2ModelTotalRevenue.fromJson(data.body);
    } catch (e) {
      EasyLoading.showToast("err:v2util:loadtotalrevenue");
    }
  }

  Future loadSalesPerformanceWeek() async {
    try {
      final data = await V2Conn().salesPerformanceWeek();
      V2Val.salesPerformanceWeek.value =
          V2ModelSalesPerformanceWeek.fromJson(data.body);
    } catch (e) {
      throw ErrorLog();
    }
  }

  Future loadSalesPerformanceMonth() async {
    try {
      final data = await V2Conn().salesPerformanceMonth();
      V2Val.salesPerformanceMonth.value =
          V2ModelSalesPerformanceWeek.fromJson(data.body);
    } catch (e) {
      throw ErrorLog();
    }
  }

  Future toRegister(Map<String, dynamic> body) async {
   try {
      final data = await V2Conn().register(body);
    print(data.body);
   } catch (e) {
     EasyLoading.showToast(e.toString());
   }
  }

  Future getListUser() async {
    try {
      final data = await V2Conn().listUser();
      V2Val.listUser.assignAll(
          List.from(data.body).map((e) => V2ModelUser.fromJson(e)).toList());
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  Future loadTop10Food()async {
    try {
      final data = await V2Conn().top10Food();
      print(data.body);
      
      V2Val.top10Food.value = List.from(data.body).map((e) => V2ModelTop10.fromJson(e)).toList();
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  Future loadTop10Beverage()async {
    try {
      final data = await V2Conn().top10Beverage();
      V2Val.top10Beverage.value = List.from(data.body).map((e) => V2ModelTop10.fromJson(e)).toList();
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  Future loadTop10Other()async {
    try {
      final data = await V2Conn().top10Other();
      V2Val.top10Other.value = List.from(data.body).map((e) => V2ModelTop10.fromJson(e)).toList();
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }
}

import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'Val.dart';
import 'conn.dart';
import 'models.dart';
import 'pref.dart';
import 'package:get/get.dart';

class Util {
  init() {
    final tgl1 = DateTime.now().toString().split(" ")[0].toString();
    final tgl2 = DateTime.now().toString().split(" ")[0].toString();

    // Val.tgl1.value = Pref.tgl1().isData() ? Pref<String>.tgl1().get() : tgl1;
    // Val.tgl2.value = Pref.tgl2().isData() ? Pref<String>.tgl2().get() : tgl2;

    Val.dep.value =
        Pref.dep().has() ? ModelDep.fromJson(Pref.dep().get()) : ModelDep();
    Val.out.value =
        Pref.out().has() ? ModelOut.fromJson(Pref.out().get()) : ModelOut();

    // if (Val.tgl1.value == "") {
    //   Val.tgl1.value = DateTime.now().toString();
    // }

    // if (Val.tgl2.value == "") {
    //   Val.tgl2.value = DateTime.now().toString();
    // }
  }

  Future<void> loadDashboard() async {
    EasyLoading.show(status: "load data ...", dismissOnTap: true);
    final dash = await Conn().dashBoard();

    try {
      final data = jsonDecode(dash.body);
      if (data.runtimeType == List<dynamic>) {
        final dataDash =
            List.from(data).map((e) => ModelDashboardV2.fromJson(e)).toList();
        Val.listDashboard.assignAll(dataDash);
        
      }

      Util().loadMasterDep();
      Util().loadMasterOut();
      Util().loadTotalRevenue();
      Util().loadAverageBill();
      Util().loadComplimentGross();
      Util().loadComplimentGross();
      Util().loadSalesPerformance();
      Util().loadSalesPerformance();
      Util().loadSalesAvarage();
      
    } catch (e) {
      EasyLoading.showToast("kesalahan penganbilan data dashboard");
      print(e.toString());
    }

    EasyLoading.dismiss();
  }

  Future<void> loadMasterDep() async {
    final dep = await Conn().masterDep();

    if (jsonDecode(dep.body).runtimeType == List<dynamic>) {
      final dataDep = List<Map<String, dynamic>>.from(jsonDecode(dep.body))
          .map((e) => ModelDep.fromJson(e))
          .toList();
      Val.masterDep.assignAll(dataDep);
    }
  }

  Future<void> loadMasterOut() async {
    final out = await Conn().masterOut();
    if (jsonDecode(out.body).runtimeType == List<dynamic>) {
      final dataOut = List.from(jsonDecode(out.body))
          .map((e) => ModelOut.fromJson(e))
          .toList();
      Val.masterOut.assignAll(dataOut);
    }
  }

  Future<void> loadTotalRevenue() async {
    try {
      final res = await Conn().totalRevenue();
      final data = ModelTotalrevenue.fromJson(Map.from(jsonDecode(res.body)));
      Val.totalRevenue.value = data;
    } catch (e) {
      print(e.toString());
      EasyLoading.showToast("failet load total revenue");
    }
  }

  Future<void> loadAverageBill() async {
    try {
      final res = await Conn().avarageBillPax();
      final data = ModelAverageBillPax.fromJson(jsonDecode(res.body));
      Val.averageBillPax.value = data;
    } catch (e) {
      print(e.toString());
      EasyLoading.showToast("failet load total revenue");
    }
  }

  Future<void> loadComplimentGross() async {
    try {
      final res = await Conn().complimentGross();
      final data = ModelComplimetGross.fromJson(jsonDecode(res.body));
      Val.complimentGross.value = data;
    } catch (e) {
      print(e.toString());
      EasyLoading.showToast("failet load total revenue");
    }
  }

  Future<void> loadSalesPerformance() async {
    print("ambil data sales performance");
    try {
      final res = await Conn().salesPerformance();
      final data = List.from(jsonDecode(res.body)).map((e) => ModelSalesPerformance.fromJson(e));
      Val.listSalesperformance.assignAll(data);
    } catch (e) {
      print(e.toString());
      EasyLoading.showToast("failet load total revenue");
    }
  }

  Future<void> loadSalesAvarage() async {
    try {
      final res = await Conn().salesAvarage();
      final data = List.from(jsonDecode(res.body)).map((e) => ModelSalesAvarage.fromJson(e));
      Val.listSalesAvarage.assignAll(data);
    } catch (e) {
      print(e.toString());
      EasyLoading.showToast("failet load total revenue");
    }
  }
}
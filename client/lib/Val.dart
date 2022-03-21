import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_report/models.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import 'conn.dart';
import 'pref.dart';

class Val {
  static final listTab = ["Dashboard", "Sales Performance", "Sales Avarage", "Empat"];
  static ModelConfig config = ModelConfig();
  static final dashboard = ModelDashboard().obs;
  static final tgl1 = DateTime.now().obs;
  static final tgl2 = DateTime.now().obs;
  static final dep = ModelDep().obs;
  static final out = ModelOut().obs;

  static final masterDep = <ModelDep>[].obs;
  static final masterOut = <ModelOut>[].obs;
  static final listDashboard = <ModelDashboardV2>[].obs;
  static final totalRevenue = ModelTotalrevenue().obs;
  static final averageBillPax = ModelAverageBillPax().obs;
  static final complimentGross = ModelComplimetGross().obs;
  static final listSalesperformance = <ModelSalesPerformance>[].obs;
  static final listSalesAvarage = <ModelSalesAvarage>[].obs;
}

class Warna {
  static const primary1 = 0xff94D0CC;
  
}


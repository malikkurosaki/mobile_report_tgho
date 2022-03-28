import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class TgUtilPref {
  // key
  late String key;
  // get storage
  final storage = GetStorage();

  // wellcome
  static final wellcomeX = true.obs;

  // dashboardx
  static final dashboardX = {}.obs;

  // deptX
  static final deptX = {}.obs;

  // masterx
  static final masterX = {}.obs;

  // product year report
  static final productYearReportX = {}.obs;

  // product month report
  static final productMonthReportX = {}.obs;

  // product week report
  static final prowductWeekReportX = {}.obs;

  // product day report
  static final productDayReportX = {}.obs;

  // year report
  static final yearReportX = {}.obs;

  // dashboard report
  static final dashboardReportX = {}.obs;

  // report by group
  static final reportByGroupX = [].obs;

  // report by dept
  static final reportByDeptX = [].obs;

  // report by out
  static final reportByOutX = [].obs;

  // report by total
  static final reportByTotalX = {}.obs;

  // report
  static final reportX = {}.obs;

  // user
  static final userX = {}.obs;

  // introX
  // static final introX = false.obs;


  // dasboard 
  TgUtilPref.dashboard({Map? value}) {
    key = 'dashboard';
    if (value != null) {
      storage.write(key, value);
      dashboardX.assignAll(Map.from(value));
    }
    dashboardX.assignAll(Map.from(storage.read(key)));
  }

  // master report
  TgUtilPref.master({Map? value}) {
    key = 'master';
    if (value != null) {
      storage.write(key, value);
      masterX.assignAll(Map.from(value));
    }
    masterX.assignAll(Map.from(storage.read(key)??{}));
  }

  // product rear report
  TgUtilPref.productYearReport({Map? value}) {
    key = 'yearReport';
    if (value != null) {
      storage.write(key, value);
      productYearReportX.assignAll(Map.from(value));
    }
    productYearReportX.assignAll(Map.from(storage.read(key)??{}));
  }

  // product month report
  TgUtilPref.productMonthReport({Map? value}) {
    key = 'monthReport';
    if (value != null) {
      storage.write(key, value);
      productMonthReportX.assignAll(Map.from(value));
    }
    productMonthReportX.assignAll(Map.from(storage.read(key)??{}));
  }

  // product week report
  TgUtilPref.productWeekReport({Map? value}) {
    key = 'weekReport';
    if (value != null) {
      storage.write(key, value);
      prowductWeekReportX.assignAll(Map.from(value));
    }
    prowductWeekReportX.assignAll(Map.from(storage.read(key)??{}));
  }

  // product day report
  TgUtilPref.productDayReport({Map? value}) {
    key = 'dayReport';
    if (value != null) {
      storage.write(key, value);
      productDayReportX.assignAll(Map.from(value));
    }
    productDayReportX.assignAll(Map.from(storage.read(key)??{}));
  }

  // dept report
  TgUtilPref.deptReport({Map? value}) {
    key = 'deptReport';
    if (value != null) {
      storage.write(key, value);
      deptX.assignAll(Map.from(value));
    }
    deptX.assignAll(Map.from(storage.read(key)??{}));
  }

  // year report
  TgUtilPref.yearReport({Map? value}) {
    key = 'yearReport';
    if (value != null) {
      storage.write(key, value);
      yearReportX.assignAll(Map.from(value));
    }
    yearReportX.assignAll(Map.from(storage.read(key)??{}));
  }

  // dashboard report
  TgUtilPref.dashboardReport({Map? value}) {
    key = 'dashboardReport';
    if (value != null) {
      storage.write(key, value);
      dashboardReportX.assignAll(Map.from(value));
    }
    dashboardReportX.assignAll(Map.from(storage.read(key)??{}));
  }

  // group
  TgUtilPref.reportByGroup({List? value}) {
    key = 'reportByGroup';
    if (value != null) {
      storage.write(key, value);
      reportByGroupX.assignAll(List.from(value));
    }
    reportByGroupX.assignAll(List.from(storage.read(key)??[]));
  }

  // dept
  TgUtilPref.reportByDept({List? value}) {
    key = 'reportByDept';
    if (value != null) {
      storage.write(key, value);
      reportByDeptX.assignAll(List.from(value));
    }
    reportByDeptX.assignAll(List.from(storage.read(key)??[]));
  }

  // out
  TgUtilPref.reportByOut({List? value}) {
    key = 'reportByOut';
    if (value != null) {
      storage.write(key, value);
      reportByOutX.assignAll(List.from(value));
    }
    reportByOutX.assignAll(List.from(storage.read(key)??[]));
  }

  // total
  TgUtilPref.reportByTotal({Map? value}) {
    key = 'reportByTotal';
    if (value != null) {
      storage.write(key, value);
      reportByTotalX.assignAll(Map.from(value));
    }
    reportByTotalX.assignAll(Map.from(storage.read(key)??{}));
  }

  // report
  TgUtilPref.report({Map? value}) {
    key = 'report';
    if (value != null) {
      storage.write(key, value);
      reportX.assignAll(Map.from(value));
    }
    reportX.assignAll(Map.from(storage.read(key)??{}));
  }

  // user
  TgUtilPref.user({Map? value}) {
    key = 'user';
    if (value != null) {
      storage.write(key, value);
      userX.assignAll(Map.from(value));
    }
    userX.assignAll(Map.from(storage.read(key)??{}));
  }

  // wellcome
  TgUtilPref.wellcome({bool? value}) {
    key = 'wellcome';
    if (value != null) {
      storage.write(key, value);
      wellcomeX.value = value;
    }
    wellcomeX.value = storage.read(key)??true;
  }

  // intro
  // TgUtilPref.intro({bool? value}) {
  //   key = 'intro';
  //   if (value != null) {
  //     storage.write(key, value);
  //     introX.value = value;
  //   }
  //   introX.value = storage.read(key)??true;
  // }
  
  get() {
    return storage.read(key);
  }

  hasData() {
    return storage.hasData(key);
  }

  remove(){
    storage.remove(key);
  }

}

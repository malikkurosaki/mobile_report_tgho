import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_report/v2_models.dart';
import 'models.dart';

class V2Val {
  static final config = V2ModelConfig().obs;
  static final tanggal1 = DateTime.now().obs;
  static final tanggal2 = DateTime.now().obs;
  static final dep = V2ModelDep.fromJson({"nama_dept": "All", "unit_bisnis": "All"}).obs;
  static final out = V2ModelOut.fromJson({"kode_out": "All", "nama_out": "All"}).obs;
  static final heroTag = "".obs;
  static final masterDep = <V2ModelDep>[].obs;
  static final masterOut = <V2ModelOut>[].obs;
  static final food = V2ModelFood().obs;
  static final beverage = V2ModelFood().obs;
  static final other = V2ModelFood().obs;
  static final totalRevenue = V2ModelTotalRevenue().obs;
  static final salesPerformanceWeek = V2ModelSalesPerformanceWeek().obs;
  static final salesPerformanceMonth = V2ModelSalesPerformanceWeek().obs;
  static final listUser = <V2ModelUser>[].obs;

  static final user = V2ModelUser().obs;
  static final isIntro = true.obs;

  static final top10Food = <V2ModelTop10>[].obs;
  static final top10Beverage = <V2ModelTop10>[].obs;
  static final top10Other = <V2ModelTop10>[].obs;
  
}

import 'package:get_storage/get_storage.dart';

class Pref {
  late String key;

  Pref.user() : key = "user";
  Pref.isLogin() : key = "isLogin";
  Pref.isIntro() : key = "isIntro";
  Pref.config() : key = "config";

  Pref.tgl1() : key = "tgl1";
  Pref.tgl2() : key = "tgl2";
  Pref.dep() : key = "dep";
  Pref.out() : key = "out";

  get() => GetStorage().read(key);
  void set(dynamic value) => GetStorage().write(key, value);
  bool has() => GetStorage().hasData(key);
  void del() => GetStorage().remove(key);
}

class TgConfig {
  static const String host = "localost";
  static const int port = 3000;
  static const String prefix = "api";
  static const String protocol = "http";
  static const String version = "v2";
  static const String baseUrl = "$protocol://$host:$port/$prefix/$version";
}

import 'package:shared_preferences/shared_preferences.dart';

class OfflineData {
  Future<String?> getOfflineData(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  Future<void> setOfflineData(String key, String data) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(key, data);
  }
}

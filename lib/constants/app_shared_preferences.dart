import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  Future<void> savePreferences(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future<String> readPreferences(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? sRetorno = sharedPreferences.getString(key);
    return sRetorno ?? "";
  }

  Future<void> removePreferences(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }

  Future<void> saveDouble(String key, double value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble(key, value);
  }

  Future<double> readDouble(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  Future<void> clearPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}

import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager{
  final logger = Logger();

  // Method to save a string value in SharedPreferences
  static Future<void> saveString(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, value);


  }
  static Future<void> setInt(String key,int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(key, value);


  }
  static Future<void> removeString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(key);


  }


  // Method to get the saved string value from SharedPreferences
  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   // logger.d("profile connection ${prefs.getString(key)}");

    return prefs.getString(key);
  }
  static Future<int?> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // logger.d("profile connection ${prefs.getString(key)}");

    return prefs.getInt(key);
  }

  static Future<void> clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // logger.d("profile connection ${prefs.getString(key)}");
    prefs.clear();
    prefs.reload();

    TranslationController _transaltoin = Get.put(TranslationController());

    _transaltoin.changeTargetLanguage("en");



  }






}
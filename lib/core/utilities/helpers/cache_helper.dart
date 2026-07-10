import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  CacheHelper._();
  static final CacheHelper instance = CacheHelper._();
  static CacheHelper getInstance()=> instance;
  late SharedPreferences _prefs;

  Future<void> init()async
  {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> putBool(String key, bool value)async
  {
    return await _prefs.setBool(key, value);
  }

  bool getBool(String key)
  {
    return  _prefs.getBool(key)??false;
  }

  Future<void> putList(String key, List<String> value)async
  {
    await _prefs.setStringList(key, value);
  }

  Future<List<String>> getList(String key)async
  {
    return _prefs.getStringList(key)??[];
  }
}
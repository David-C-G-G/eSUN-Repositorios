

import 'package:shared_preferences/shared_preferences.dart';
import 'package:esun/shared/services/key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService{

  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getKey<T>(String key) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
  
      case String:
        return prefs.getString(key) as T?;
        
      default:
      throw UnimplementedError('GET no implementado para el tipo ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        prefs.setInt(key, value as int);
        break;
      case String:
        prefs.setString(key, value as String);
        break;
      default:
      throw UnimplementedError('Set no implementado para el tipo ${T.runtimeType}');
    }
  }
}
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SharedDb {
  SharedPreferences? _prefs;

  SharedDb();

  /// Инициализация SharedPreferences (вызвать один раз при старте приложения)
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Проверка инициализации
  void _checkInitialized() {
    if (_prefs == null) {
      throw Exception('SharedDb не инициализирован. Вызовите init() перед использованием.');
    }
  }

  /// Сохранение строкового значения
  Future<bool> setString(String key, String value) async {
    _checkInitialized();
    return _prefs!.setString(key, value);
  }

  /// Получение строкового значения
  String? getString(String key) {
    _checkInitialized();
    return _prefs!.getString(key);
  }

  /// Сохранение булева значения
  Future<bool> setBool(String key, bool value) async {
    _checkInitialized();
    return _prefs!.setBool(key, value);
  }

  /// Получение булева значения
  bool? getBool(String key) {
    _checkInitialized();
    return _prefs!.getBool(key);
  }

  /// Сохранение целочисленного значения
  Future<bool> setInt(String key, int value) async {
    _checkInitialized();
    return _prefs!.setInt(key, value);
  }

  /// Получение целочисленного значения
  int? getInt(String key) {
    _checkInitialized();
    return _prefs!.getInt(key);
  }

  /// Сохранение числа с плавающей точкой
  Future<bool> setDouble(String key, double value) async {
    _checkInitialized();
    return _prefs!.setDouble(key, value);
  }

  /// Получение числа с плавающей точкой
  double? getDouble(String key) {
    _checkInitialized();
    return _prefs!.getDouble(key);
  }

  /// Сохранение списка строк
  Future<bool> setStringList(String key, List<String> value) async {
    _checkInitialized();
    return _prefs!.setStringList(key, value);
  }

  /// Получение списка строк
  List<String>? getStringList(String key) {
    _checkInitialized();
    return _prefs!.getStringList(key);
  }

  /// Удаление значения по ключу
  Future<bool> remove(String key) async {
    _checkInitialized();
    return _prefs!.remove(key);
  }

  /// Полная очистка хранилища
  Future<bool> clear() async {
    _checkInitialized();
    return _prefs!.clear();
  }

  /// Проверка наличия ключа
  bool containsKey(String key) {
    _checkInitialized();
    return _prefs!.containsKey(key);
  }
}

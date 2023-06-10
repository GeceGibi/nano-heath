// ignore_for_file: constant_identifier_names

part of 'services.dart';

enum StorageKeys {
  auth_data,
  user_info,
}

class Storage {
  Storage._();
  static final instance = Storage._();
  late SharedPreferences preferences;

  //? Helper
  String getKey(StorageKeys key) => '@${key.name}';
  bool contains(StorageKeys key) {
    return preferences.containsKey(getKey(key));
  }

  void setJson<T>(StorageKeys key, T value) {
    preferences.setString(getKey(key), jsonEncode(value));
  }

  Map<K, V> getJsonMap<K, V>(StorageKeys key, {Map<K, V> fallback = const {}}) {
    return Map<K, V>.from(
      contains(key)
          ? jsonDecode(preferences.getString(getKey(key))!)
          : fallback,
    );
  }

  List<T> getJsonList<T>(StorageKeys key, {List<T> fallback = const []}) {
    return List<T>.from(
      contains(key)
          ? jsonDecode(preferences.getString(getKey(key))!)
          : fallback,
    );
  }

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}

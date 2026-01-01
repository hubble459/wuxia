import 'dart:io' show Platform;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static const String orderReadingKey = 'ORDER_BY_READING';
  static const String orderMangaKey = 'ORDER_BY_MANGA';
  static const String tokenKey = 'token';
  static const String usernameKey = 'username';
  static const String apiHostKey = 'api_url';
  static const String languageKey = 'language';
  static const String dataSaverKey = 'data_saver';

  static late final Store _instance;

  final FlutterSecureStorage? _secureStorage;
  final SharedPreferences _publicStorage;

  Store._(this._secureStorage, this._publicStorage);

  static Future<Store> init() async {
    _instance = Store._(Platform.isLinux ? null : FlutterSecureStorage(), await SharedPreferences.getInstance());
    return _instance;
  }

  static Store getStoreInstance() {
    return _instance;
  }

  Future<void> setToken(String token) async {
    if (_secureStorage != null) {
      await _secureStorage!.write(key: tokenKey, value: token);
    } else {
      await _publicStorage.setString(tokenKey, token);
    }
  }

  Future<void> removeToken() async {
    if (_secureStorage != null) {
      await _secureStorage!.delete(key: tokenKey);
    } else {
      await _publicStorage.remove(tokenKey);
    }
  }

  Future<String?> readToken() async {
    if (_secureStorage != null) {
      return _secureStorage!.read(key: tokenKey);
    } else {
      return _publicStorage.getString(tokenKey);
    }
  }

  String? getUsername() {
    return _publicStorage.getString(usernameKey);
  }

  Future<void> setUsername(String username) async {
    await _publicStorage.setString(usernameKey, username);
  }

  String? getApiHost() {
    return _publicStorage.getString(apiHostKey);
  }

  Future<void> setApiHost(String apiURL) async {
    await _publicStorage.setString(apiHostKey, apiURL);
  }

  String? getLanguage() {
    return _publicStorage.getString(languageKey);
  }

  Future<void> setLanguage(String language) async {
    await _publicStorage.setString(languageKey, language);
  }

  String? getMangaOrder() {
    return _publicStorage.getString(orderMangaKey);
  }

  Future<void> setOrderManga(String orderBy) async {
    await _publicStorage.setString(orderMangaKey, orderBy);
  }

  String? getReadingOrder() {
    return _publicStorage.getString(orderReadingKey);
  }

  Future<void> setOrderReading(String orderBy) async {
    await _publicStorage.setString(orderReadingKey, orderBy);
  }

  bool? getDataSaver() {
    return _publicStorage.getBool(dataSaverKey);
  }

  Future<void> setDataSaver(bool dataSaver) async {
    await _publicStorage.setBool(dataSaverKey, dataSaver);
  }
}

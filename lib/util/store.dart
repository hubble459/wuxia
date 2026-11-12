import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuxia/util/image_quality.dart';

class Store {
  static const String orderReadingKey = 'ORDER_BY_READING';
  static const String orderMangaKey = 'ORDER_BY_MANGA';
  static const String tokenKey = 'token';
  static const String usernameKey = 'username';
  static const String apiHostKey = 'api_url';
  static const String languageKey = 'language';
  static const String imageQualityKey = 'image_quality';

  /// The on/off setting [imageQualityKey] replaced; only read to carry an enabled data saver over.
  static const String dataSaverKey = 'data_saver';
  static const String downloadDirKey = 'download_dir';
  static const String downloadQueueKey = 'download_queue';
  static const String rootNavTabKey = 'root_nav_tab_name';
  static const String forYouFilterKey = 'for_you_filter';
  static const String readingModeKey = 'reading_mode';
  static const String mangaReadingModeKeyPrefix = 'reading_mode_manga_';
  static const String pendingProgressKeyPrefix = 'pending_progress_manga_';
  static const String pendingProgressChapterKeyPrefix = 'pending_progress_chapter_manga_';

  static late final Store _instance;

  final FlutterSecureStorage? _secureStorage;
  final SharedPreferences _publicStorage;

  Store._(this._secureStorage, this._publicStorage);

  static Future<Store> init() async {
    _instance = Store._((!kIsWeb && Platform.isLinux) ? null : FlutterSecureStorage(), await SharedPreferences.getInstance());
    return _instance;
  }

  static Store getStoreInstance() {
    return _instance;
  }

  Future<void> setToken(String token) async {
    if (_secureStorage != null) {
      await _secureStorage.write(key: tokenKey, value: token);
    } else {
      await _publicStorage.setString(tokenKey, token);
    }
  }

  Future<void> removeToken() async {
    if (_secureStorage != null) {
      await _secureStorage.delete(key: tokenKey);
    } else {
      await _publicStorage.remove(tokenKey);
    }
  }

  Future<String?> readToken() async {
    if (_secureStorage != null) {
      return _secureStorage.read(key: tokenKey);
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

  ImageQuality getImageQuality() {
    final stored = ImageQuality.fromName(_publicStorage.getString(imageQualityKey));
    if (stored != null) return stored;
    return _publicStorage.getBool(dataSaverKey) == true ? ImageQuality.medium : ImageQuality.original;
  }

  Future<void> setImageQuality(ImageQuality quality) async {
    await _publicStorage.setString(imageQualityKey, quality.name);
    await _publicStorage.remove(dataSaverKey);
  }

  String? getDownloadDir() {
    return _publicStorage.getString(downloadDirKey);
  }

  Future<void> setDownloadDir(String path) async {
    await _publicStorage.setString(downloadDirKey, path);
  }

  Future<void> clearDownloadDir() async {
    await _publicStorage.remove(downloadDirKey);
  }

  String getReadingMode() {
    return _publicStorage.getString(readingModeKey) ?? 'webtoon';
  }

  Future<void> setReadingMode(String mode) async {
    await _publicStorage.setString(readingModeKey, mode);
  }

  String? getMangaReadingMode(int mangaId) {
    return _publicStorage.getString('$mangaReadingModeKeyPrefix$mangaId');
  }

  Future<void> setMangaReadingMode(int mangaId, String mode) async {
    await _publicStorage.setString('$mangaReadingModeKeyPrefix$mangaId', mode);
  }

  /// A reading-progress update that failed to reach the server (offline)
  /// and still needs syncing -- overwritten by each newer attempt, so this
  /// only ever holds the single latest value per manga, not a history.
  int? getPendingProgress(int mangaId) {
    return _publicStorage.getInt('$pendingProgressKeyPrefix$mangaId');
  }

  int? getPendingProgressChapterId(int mangaId) {
    return _publicStorage.getInt('$pendingProgressChapterKeyPrefix$mangaId');
  }

  Future<void> setPendingProgress(int mangaId, {required int progress, int? chapterId}) async {
    await _publicStorage.setInt('$pendingProgressKeyPrefix$mangaId', progress);
    if (chapterId != null) {
      await _publicStorage.setInt('$pendingProgressChapterKeyPrefix$mangaId', chapterId);
    } else {
      await _publicStorage.remove('$pendingProgressChapterKeyPrefix$mangaId');
    }
  }

  Future<void> clearPendingProgress(int mangaId) async {
    await _publicStorage.remove('$pendingProgressKeyPrefix$mangaId');
    await _publicStorage.remove('$pendingProgressChapterKeyPrefix$mangaId');
  }

  /// The download queue as saved by `DownloadManager`, one encoded task per
  /// entry, so it survives an app restart (or a page reload on web).
  List<String> getDownloadQueue() {
    return _publicStorage.getStringList(downloadQueueKey) ?? [];
  }

  Future<void> setDownloadQueue(List<String> queue) async {
    if (queue.isEmpty) {
      await _publicStorage.remove(downloadQueueKey);
    } else {
      await _publicStorage.setStringList(downloadQueueKey, queue);
    }
  }

  /// The bottom-nav tab that was open last, so a restart (or a page reload
  /// on web) reopens it.
  /// Stored by name, not position, so adding or moving a tab doesn't reopen the wrong one.
  String? getRootNavTab() {
    return _publicStorage.getString(rootNavTabKey);
  }

  Future<void> setRootNavTab(String tab) async {
    await _publicStorage.setString(rootNavTabKey, tab);
  }

  /// The For You deck's filter, as JSON.
  String? getForYouFilter() {
    return _publicStorage.getString(forYouFilterKey);
  }

  Future<void> setForYouFilter(String filter) async {
    await _publicStorage.setString(forYouFilterKey, filter);
  }
}

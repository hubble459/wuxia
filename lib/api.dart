import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:grpc/grpc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wuxia/gen/rumgap.pbgrpc.dart';
import 'package:wuxia/model/chapter.dart';
import 'package:wuxia/model/manga.dart';
import 'package:wuxia/model/paginate.dart';
import 'package:wuxia/model/reading.dart';
import 'package:wuxia/model/search_manga.dart';

enum Method {
  get,
  post,
  delete,
  patch,
}

class Api {
  static const url = '10.0.2.2';
  static const port = 8000;
  final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };
  final HttpClient client = HttpClient();

  Api() {
    client.connectionTimeout = const Duration(seconds: 10);
  }

  Future<bool> testToken(String? token) async {
    if (token == null) {
      return false;
    }

    headers[HttpHeaders.authorizationHeader] = token;
    try {
      await _request(method: Method.get, path: 'auth');
      await const FlutterSecureStorage().write(key: 'token', value: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> login(
      {required String username, required String password}) async {
    final response = await _request(
        method: Method.post,
        path: 'login',
        data: jsonEncode({'username': username, 'password': password}));
    final token = 'Bearer ${response["token"]}';
    headers[HttpHeaders.authorizationHeader] = token;
    await const FlutterSecureStorage().write(key: 'token', value: token);
  }

  Future<void> register(
      {required String username, required String password}) async {
    final response = await _request(
        method: Method.post,
        path: 'register',
        data: jsonEncode({'username': username, 'password': password}));
    final token = 'Bearer ${response["token"]}';
    headers[HttpHeaders.authorizationHeader] = token;
    await const FlutterSecureStorage().write(key: 'token', value: token);
  }

  Future<Paginate<Reading>> allReading(
      {int page = 1, int limit = 20, String? keyword}) async {
    final response = await _request(
        method: Method.get,
        path: 'reading',
        queries: {'page': page, 'limit': limit, 'keyword': keyword});
    return Paginate<Reading>.fromJson(response, Reading.fromJson);
  }

  Future<Paginate<Manga>> allManga({int page = 1, int limit = 20}) async {
    final response = await _request(
        method: Method.get,
        path: 'manga',
        queries: {'page': page, 'limit': limit});
    return Paginate<Manga>.fromJson(response, Manga.fromJson);
  }

  Future<void> removeReading(Reading reading) async {
    await _request(method: Method.delete, path: 'reading/${reading.manga.id}');
  }

  Future<Reading> reading(int mangaId) async {
    final response =
        await _request(method: Method.get, path: 'reading/$mangaId');
    return Reading.fromJson(response);
  }

  Future<Manga> manga(int id, {bool force = false}) async {
    final response = await _request(
        method: Method.get,
        path: 'manga/$id',
        queries: {'force_refresh': force.toString()});
    return Manga.fromJson(response);
  }

  Future<Manga> addManga(Uri url) async {
    final response = await _request(
        method: Method.post,
        path: 'manga',
        data: jsonEncode({'url': url.toString()}));
    return Manga.fromJson(response);
  }

  Future<Chapter> chapter(Reading reading) async {
    final response = await _request(
        method: Method.get,
        path: 'manga/${reading.manga.id}/chapter/${reading.progress}');
    return Chapter.fromJson(response);
  }

  Future<List<Uri>> images(int mangaId, Chapter chapter) async {
    final Iterable response = await _request(
        method: Method.get,
        path: 'manga/$mangaId/chapter/${chapter.id}/images');
    return List<Uri>.from(response.map((json) => Uri.parse(json)));
  }

  Future<void> updateProgress(Reading reading) async {
    await _request(
        method: Method.patch,
        path: 'reading/${reading.manga.id}',
        data: jsonEncode({'progress': reading.progress}));
  }

  Future<Reading> addToReading(Manga manga) async {
    final response = await _request(
        method: Method.post,
        path: 'reading',
        data: jsonEncode({'manga_id': manga.id}));
    return Reading.fromJson(response);
  }

  Future<Paginate<Chapter>> chapters(int id,
      {int page = 1, int limit = 20}) async {
    final response = await _request(
        method: Method.get,
        path: 'manga/$id/chapter',
        queries: {'page': page, 'limit': limit});
    return Paginate<Chapter>.fromJson(response, Chapter.fromJson);
  }

  Future<List<SearchManga>> search(String keyword,
      {List<String> hostnames = const ['mangadex.org']}) async {
    final Iterable response = await _request(
        method: Method.get,
        path:
            'search?keyword=$keyword&hostnames[]=${hostnames.join('&hostnames[]=')}');
    return List<SearchManga>.from(
        response.map((json) => SearchManga.fromJson(json)));
  }

  Future<dynamic> _request(
      {required Method method,
      required String path,
      String? data,
      Map<String, dynamic>? queries}) async {
    path = '/api${path.startsWith('/') ? '' : '/'}$path';

    String query = '?';
    if (queries != null) {
      queries.forEach((key, value) {
        if (value is List) {
          for (var val in value) {
            val = Uri.encodeQueryComponent(val);
            query += '$key[]=$val&';
          }
        } else {
          value = Uri.encodeQueryComponent(value.toString());
          query += '$key=$value&';
        }
      });
    }

    // Remove ? if no queries or remove trailing &
    // And add to path
    path += query.substring(0, query.length - 1);

    switch (method) {
      case Method.get:
        final HttpClientRequest request = await client.get(url, port, path);
        return _json(request);
      case Method.post:
        final HttpClientRequest request = await client.post(url, port, path);
        return _json(request, data);
      case Method.delete:
        final HttpClientRequest request = await client.delete(url, port, path);
        return _json(request);
      case Method.patch:
        final HttpClientRequest request = await client.patch(url, port, path);
        return _json(request, data);
    }
  }

  Future<dynamic> _json(HttpClientRequest request, [String? data]) async {
    log('[${request.method}] ${request.uri}');
    headers.forEach((key, value) {
      request.headers.set(key, value);
    });
    if (data != null) {
      request.write(data);
    }

    final beforeMs = DateTime.now();
    final HttpClientResponse response = await request.close();
    dynamic jsonData = {};
    final String? contentType =
        response.headers.value(HttpHeaders.contentTypeHeader);
    if (contentType != null && contentType.contains('application/json')) {
      final String jsonString = await response.transform(utf8.decoder).join();
      jsonData = jsonDecode(jsonString);
    }

    if (response.statusCode >= 400) {
      // If unauthorized remove stored tokens
      if (response.statusCode == 401) {
        await const FlutterSecureStorage().delete(key: 'token');
        headers.remove(HttpHeaders.authorizationHeader);
      }
      log('[${response.statusCode}] ms: ${DateTime.now().difference(beforeMs).inMilliseconds}, error: ${jsonData.toString()}');

      throw jsonData;
    } else {
      log('[${response.statusCode}] ms: ${DateTime.now().difference(beforeMs).inMilliseconds}, hasData: ${jsonData != null}');
    }

    return jsonData;
  }
}

// Api api = Api();

//// gRCP

var _channel = ClientChannel(
  '10.0.2.2',
  port: 8000,
  options: const ChannelOptions(
    credentials: ChannelCredentials.insecure(),
  ),
);

class API {
  static final Map<String, String> _metadata = {};
  final user = UserClient(_channel, options: CallOptions(metadata: _metadata));
  final manga =
      MangaClient(_channel, options: CallOptions(metadata: _metadata));
  final chapter =
      ChapterClient(_channel, options: CallOptions(metadata: _metadata));
  final reading =
      ReadingClient(_channel, options: CallOptions(metadata: _metadata));
  final friend =
      FriendClient(_channel, options: CallOptions(metadata: _metadata));
  set token(String token) {
    API._metadata['authorization'] = 'Bearer $token';
  }
}

API api = API();

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pbgrpc.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';

// localhost=10.0.2.2:8000
const _defaultHost = '31.21.216.97';
const _defaultPort = 5909;

// gRCP
class API {
  static String? _token;
  static late UserFullReply loggedIn;
  late final ClientChannel _channel;
  late final UserClient user = UserClient(_channel, options: options);
  late final MangaClient manga = MangaClient(_channel, options: options);
  late final ChapterClient chapter = ChapterClient(_channel, options: options);
  late final ReadingClient reading = ReadingClient(_channel, options: options);
  late final FriendClient friend = FriendClient(_channel, options: options);
  late final SearchClient search = SearchClient(_channel, options: options);
  late final MetaClient meta = MetaClient(_channel, options: options);

  static void authProvider(Map<String, String> metadata, uri) {
    if (_token != null) {
      metadata['authorization'] = 'Bearer $_token';
    }
  }

  static Future<bool> test(String host, int port) async {
    var test = API(host, port);

    try {
      await test.user.me(Empty()).timeout(const Duration(seconds: 2));
    } catch (e) {
      print(e);
      if (e is GrpcError) {
        return e.code == StatusCode.unauthenticated;
      }

      return false;
    }

    return true;
  }

  String getApiURL() {
    return '${_channel.host}:${_channel.port}';
  }

  void reset() {
    api = API(_defaultHost, _defaultPort);
  }

  API(String host, int port) {
    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectTimeout: Duration(seconds: 5),
      ),
    );
  }

  static set token(String? token) {
    API._token = token;
  }

  static final options = CallOptions(
    providers: [API.authProvider],
    compression: const GzipCodec(),
  );
}

API api = API(_defaultHost, _defaultPort);

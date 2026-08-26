import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart' show ClientChannelBase;
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pbgrpc.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';

// const _defaultHost = '10.0.2.2';
// const _defaultPort = 8000;
const _defaultHost = '31.21.216.97';
const _defaultPort = 5909;

// extension PooPoo on GrpcError {}

// gRCP
class API {
  static String? _token;
  static late UserFullReply loggedIn;
  final String host;
  final int port;
  late final ClientChannelBase _channel;
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
    return '$host:$port';
  }

  void reset() {
    api = API(_defaultHost, _defaultPort);
  }

  API(this.host, this.port) {
    // Uses raw gRPC (HTTP/2 sockets) everywhere except web, where it falls
    // back to gRPC-Web (XHR) since browsers can't open raw sockets. The
    // server must speak both protocols on this host/port for web to work.
    _channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
      host: host,
      port: port,
      transportSecure: false,
    );
  }

  static set token(String? token) {
    API._token = token;
  }

  static final options = CallOptions(
    providers: [API.authProvider],
    compression: const GzipCodec(),
    timeout: Duration(seconds: 6),
  );
}

API api = API(_defaultHost, _defaultPort);

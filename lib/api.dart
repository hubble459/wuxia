import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart' show ClientChannelBase;
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pbgrpc.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/util/validator_builder.dart';

// The rumgap API's URL, reached over grpc-web (web) or raw grpc (native).
const _rawApiHost = String.fromEnvironment('API_HOST', defaultValue: 'localhost');

// API_HOST has historically been a bare hostname (still how it's set in CI),
// completed here with this platform's default port/scheme; a full URL (e.g.
// `https://host:port`, needed to reach a self-hosted server on a non-standard
// port) is used as-is.
final String _defaultApiUrl =
    _rawApiHost.contains('://') ? _rawApiHost : (kIsWeb ? 'https://$_rawApiHost' : 'https://$_rawApiHost:5909');

// extension PooPoo on GrpcError {}

// Mirrors UserPermissions::ADMIN (0b00000100) on the server -- see interceptor/auth.rs.
const _adminPermissionBit = 0x4;

extension UserPermissionsX on UserFullReply {
  bool get isAdmin => permissions & _adminPermissionBit != 0;
}

// gRCP
class API {
  static String? _token;
  static late UserFullReply loggedIn;
  final String url;
  late final ClientChannelBase _channel;
  late final UserClient user = UserClient(_channel, options: options);
  late final MangaClient manga = MangaClient(_channel, options: options);
  late final ChapterClient chapter = ChapterClient(_channel, options: options);
  late final ReadingClient reading = ReadingClient(_channel, options: options);
  late final FriendClient friend = FriendClient(_channel, options: options);
  late final SearchClient search = SearchClient(_channel, options: options);
  late final MetaClient meta = MetaClient(_channel, options: options);
  late final ScraperClient scraper = ScraperClient(_channel, options: options);

  static void authProvider(Map<String, String> metadata, uri) {
    if (_token != null) {
      metadata['authorization'] = 'Bearer $_token';
    }
  }

  static Future<bool> test(String url) async {
    var test = API(url);

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
    return url;
  }

  void reset() {
    api = API(_defaultApiUrl);
  }

  API(this.url) {
    final parsed = parseApiUrl(url)!;
    // Uses raw gRPC (HTTP/2 sockets) everywhere except web, where it falls
    // back to gRPC-Web (XHR) since browsers can't open raw sockets. The
    // server must speak both protocols on this host/port for web to work.
    _channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
      host: parsed.host,
      port: parsed.port,
      transportSecure: parsed.secure,
    );
  }

  static set token(String? token) {
    API._token = token;
  }

  static bool get isLoggedIn => _token != null;

  static final options = CallOptions(
    providers: [API.authProvider],
    compression: const GzipCodec(),
    timeout: Duration(seconds: 12),
  );
}

API api = API(_defaultApiUrl);

import 'package:grpc/grpc.dart';
import 'package:wuxia/gen/rumgap.pbgrpc.dart';

import 'gen/user.pb.dart';

// gRCP
var _channel = ClientChannel(
  '10.0.2.2',
  port: 8000,
  options: const ChannelOptions(
    credentials: ChannelCredentials.insecure(),
  ),
);

class API {
  static String? _token;
  static late UserFullReply loggedIn;

  static void authProvider(Map<String, String> metadata, uri) {
    if (_token != null) {
      metadata['authorization'] = 'Bearer $_token';
    }
  }

  API._();

  static set token(String? token) {
    API._token = token;
  }

  static final options = CallOptions(
    providers: [API.authProvider],
    compression: const GzipCodec(),
    timeout: const Duration(seconds: 5),
  );
  final user = UserClient(_channel, options: options);
  final manga = MangaClient(_channel, options: options);
  final chapter = ChapterClient(_channel, options: options);
  final reading = ReadingClient(_channel, options: options);
  final friend = FriendClient(_channel, options: options);
  final search = SearchClient(_channel, options: options);
  final meta = MetaClient(_channel, options: options);
}

API api = API._();

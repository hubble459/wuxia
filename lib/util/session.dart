import 'package:grpc/grpc.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/util/store.dart';

bool _restoreAttempted = false;

/// Restores the persisted API host + auth token into [api]/[API].
///
/// On web, a deep link (or a page refresh) can land the app directly on a
/// route like RootNavScreen or SettingsScreen, skipping SplashScreen -- the
/// only place this used to run -- entirely. Protected screens call this
/// themselves so credentials are available no matter how they were reached.
/// Idempotent: only does the work the first time it's called.
Future<void> restoreSession() async {
  if (_restoreAttempted) return;
  _restoreAttempted = true;

  final store = Store.getStoreInstance();
  final apiURL = store.getApiHost();
  if (apiURL != null && api.getApiURL() != apiURL) {
    final parts = apiURL.split(':');
    api = API(parts[0], int.parse(parts[1]));
  }

  final token = await store.readToken();
  if (token == null) return;

  API.token = token;
  try {
    API.loggedIn = await api.user.me(Empty());
  } catch (e) {
    if (e is GrpcError && e.code == StatusCode.unauthenticated) {
      await store.removeToken();
      API.token = null;
    } else {
      // Network error -- continue offline with empty user.
      API.loggedIn = UserFullReply();
    }
  }
}

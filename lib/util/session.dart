import 'package:grpc/grpc.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart';
import 'package:wuxia/util/store.dart';

Future<void>? _restoreFuture;

/// Restores the persisted API host + auth token into [api]/[API].
///
/// On web, a deep link (or a page refresh) can land the app directly on a
/// route like RootNavScreen or SettingsScreen, skipping SplashScreen -- the
/// only place this used to run -- entirely. Protected screens call this
/// themselves so credentials are available no matter how they were reached.
///
/// A deep link also seeds a buried root_nav route alongside the visible one
/// (see main.dart's onGenerateInitialRoutes), so this is commonly called by
/// more than one screen around the same time -- memoize the Future itself,
/// not just a "started" flag, so a later caller actually awaits the first
/// call's in-flight work instead of seeing it as instantly (and wrongly)
/// "done" before the token read/validation has resolved.
Future<void> restoreSession() => _restoreFuture ??= _restoreSession();

Future<void> _restoreSession() async {
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

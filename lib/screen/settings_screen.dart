import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart' show Empty;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wuxia/util/store.dart';
import 'package:wuxia/partial/dialog/change_password_dialog.dart';
import 'package:wuxia/partial/download_reconnect.dart';
import 'package:wuxia/util/download_migration.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/util/session.dart';
import 'package:wuxia/util/tools.dart';

const languages = [Locale('zh'), Locale('en'), Locale('nl')];

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _locale;
  String? _downloadDir;
  DownloadStorageStatus? _downloadStatus;
  String? _downloadSize;
  PackageInfo? _packageInfo;

  // A web deep link can land here directly, skipping SplashScreen/RootNavScreen
  // -- the places credentials normally get restored before this screen reads
  // API.loggedIn. Redo the restore here too (no-op if already done).
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await restoreSession();
    if (!mounted) return;

    if (!API.isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('login');
      return;
    }

    setState(() => _ready = true);
    if (downloadsSupported) _loadDownloadInfo();

    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _packageInfo = info);
  }

  Future<void> _loadDownloadInfo() async {
    final status = await downloadStorage.status();
    final location = await downloadStorage.location();
    if (!mounted) return;
    setState(() {
      _downloadStatus = status;
      _downloadDir = location ?? FlutterI18n.translate(context, 'downloads.browser_storage');
      _downloadSize = null;
    });
    if (status != DownloadStorageStatus.ready) return;

    final size = await downloadStorage.totalSize();
    if (!mounted) return;
    setState(() => _downloadSize = _formatBytes(size));
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  Future<void> _clearDownloads() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(FlutterI18n.translate(ctx, 'dialog.confirm.title')),
        content: Text(FlutterI18n.translate(ctx, 'settings.download_clear_confirm')),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(FlutterI18n.translate(ctx, 'dialog.confirm.no'))),
          TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text(FlutterI18n.translate(ctx, 'dialog.confirm.yes'))),
        ],
      ),
    );
    if (confirmed != true) return;

    await deleteAllDownloads();
    _loadDownloadInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final store = Store.getStoreInstance();
    _locale ??= FlutterI18n.currentLocale(context)?.languageCode;

    return Scaffold(
      appBar: AppBar(title: I18nText('settings.title')),
      body: ResponsiveContent(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.all(8.0), child: I18nText('settings.misc')),
              SwitchListTile(
                value: store.getDataSaver() ?? false,
                onChanged: (v) {
                  store.setDataSaver(v);
                  setState(() {});
                },
                title: I18nText('settings.data_saver'),
              ),
              SwitchListTile(
                value: API.loggedIn.showNsfw,
                onChanged: (show) async {
                  try {
                    API.loggedIn = await api.user.update(UserUpdateRequest(showNsfw: show));
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                  if (mounted) setState(() {});
                },
                title: I18nText('settings.show_nsfw'),
                subtitle: I18nText('settings.show_nsfw_hint'),
              ),
              ListTile(
                title: I18nText('settings.language'),
                trailing: DropdownButton<String>(
                  value: _locale,
                  items: languages
                      .map((locale) => DropdownMenuItem<String>(value: locale.languageCode, child: Text(locale.languageCode)))
                      .toList(),
                  onChanged: (locale) async {
                    if (FlutterI18n.currentLocale(context)?.languageCode != locale) {
                      _locale = locale;

                      await store.setLanguage(locale!);
                      if (context.mounted) {
                        await FlutterI18n.refresh(context, Locale(locale));
                        await Jiffy.setLocale(locale);

                        setState(() {});
                      }
                    }
                  },
                ),
              ),
              ListTile(
                title: I18nText('settings.reading_mode'),
                trailing: DropdownButton<String>(
                  value: store.getReadingMode(),
                  items: [
                    DropdownMenuItem<String>(
                      value: 'webtoon',
                      child: Text(FlutterI18n.translate(context, 'settings.reading_mode_webtoon')),
                    ),
                    DropdownMenuItem<String>(
                      value: 'paged',
                      child: Text(FlutterI18n.translate(context, 'settings.reading_mode_paged')),
                    ),
                    DropdownMenuItem<String>(
                      value: 'paged_rtl',
                      child: Text(FlutterI18n.translate(context, 'settings.reading_mode_paged_rtl')),
                    ),
                  ],
                  onChanged: (mode) async {
                    if (mode == null) return;
                    await store.setReadingMode(mode);
                    setState(() {});
                  },
                ),
              ),
              ListTile(
                title: I18nText('settings.statistics.title'),
                onTap: () {
                  Navigator.of(context).pushNamed('statistics');
                },
              ),
              ListTile(
                title: I18nText('settings.preferred_sources.title'),
                subtitle: I18nText('settings.preferred_sources.description'),
                onTap: () {
                  Navigator.of(context).pushNamed('preferred_sources');
                },
              ),
              if (API.loggedIn.isAdmin)
                ListTile(
                  title: I18nText('settings.scraper_status.title'),
                  onTap: () {
                    Navigator.of(context).pushNamed('scraper_status');
                  },
                ),
              if (API.loggedIn.isAdmin)
                ListTile(
                  title: I18nText('settings.users.title'),
                  onTap: () {
                    Navigator.of(context).pushNamed('users');
                  },
                ),
              if (!kIsWeb)
                ListTile(title: I18nText('settings.check_update'), onTap: () => launchUrlString(githubWuxiaReleasesUrl)),
              if (downloadsSupported) ...[
                const Divider(),
                Padding(padding: const EdgeInsets.all(8.0), child: I18nText('settings.download')),
                ListTile(
                  title: I18nText('settings.download_directory'),
                  subtitle: Text(switch (_downloadStatus) {
                    DownloadStorageStatus.needsPermission => FlutterI18n.translate(
                      context,
                      'downloads.reconnect_message',
                      translationParams: {'folder': _downloadDir ?? ''},
                    ),
                    _ when downloadStorage.isPrivate =>
                      '${_downloadDir ?? '…'}\n${FlutterI18n.translate(context, 'downloads.browser_storage_hint')}',
                    _ => _downloadDir ?? '…',
                  }),
                  trailing: _downloadStatus == DownloadStorageStatus.needsPermission
                      ? TextButton(
                          onPressed: () async {
                            if (await reconnectDownloads(context)) _loadDownloadInfo();
                          },
                          child: Text(FlutterI18n.translate(context, 'downloads.reconnect')),
                        )
                      : downloadStorage.canPickLocation
                      ? const Icon(Icons.folder_open)
                      : null,
                  onTap: downloadStorage.canPickLocation
                      ? () async {
                          if (await downloadStorage.pickLocation()) _loadDownloadInfo();
                        }
                      : null,
                  onLongPress: () async {
                    await downloadStorage.resetLocation();
                    _loadDownloadInfo();
                  },
                ),
                ValueListenableBuilder<List<String>>(
                  valueListenable: downloadMigrationConflicts,
                  builder: (context, conflicts, _) => conflicts.isEmpty
                      ? const SizedBox.shrink()
                      : ListTile(
                          leading: const Icon(Icons.warning_amber),
                          title: Text(
                            FlutterI18n.translate(
                              context,
                              'downloads.migration_conflicts',
                              translationParams: {'count': '${conflicts.length}'},
                            ),
                          ),
                          subtitle: Text(conflicts.join('\n')),
                        ),
                ),
                ListTile(
                  title: Text(
                    FlutterI18n.translate(context, 'settings.download_clear'),
                    style: const TextStyle(color: Colors.red),
                  ),
                  subtitle: Text(_downloadSize ?? '…'),
                  onTap: _clearDownloads,
                ),
              ],
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    I18nText('settings.account'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text(API.loggedIn.username), Text(API.loggedIn.email)],
                    ),
                  ],
                ),
              ),
              ListTile(title: I18nText('settings.edit_account'), onTap: () {}),
              ListTile(
                title: I18nText('settings.change_password.title'),
                onTap: () async {
                  final changed = await showDialog<bool>(context: context, builder: (context) => const ChangePasswordDialog());
                  if (changed != true || !context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: I18nText('settings.change_password.changed')));
                },
              ),
              ListTile(
                title: Text(FlutterI18n.translate(context, 'settings.logout'), style: const TextStyle(color: Colors.red)),
                onTap: () async {
                  try {
                    await api.user.logout(Empty()).timeout(const Duration(seconds: 5));
                  } catch (_) {
                    // Offline or already revoked - still log out locally.
                  }
                  await Store.getStoreInstance().removeToken();
                  API.token = null;
                  if (!context.mounted) {
                    return;
                  }
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('login');
                },
              ),
              ListTile(
                title: Text(FlutterI18n.translate(context, 'settings.remove_account'), style: const TextStyle(color: Colors.red)),
                onTap: () {},
              ),
              if (_packageInfo != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      FlutterI18n.translate(
                        context,
                        'settings.version',
                        translationParams: {'version': _packageInfo!.version, 'build': _packageInfo!.buildNumber},
                      ),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

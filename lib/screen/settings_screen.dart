import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/partial/dialog/update_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wuxia/util/store.dart';
import 'package:file_selector/file_selector.dart';
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
  String? _downloadSize;

  @override
  void initState() {
    super.initState();
    _loadDownloadInfo();
  }

  Future<void> _loadDownloadInfo() async {
    final dir = await getDownloadDirectory();
    if (!mounted) return;
    setState(() => _downloadDir = dir.path);

    final size = await _calcSize(dir);
    if (!mounted) return;
    setState(() => _downloadSize = _formatBytes(size));
  }

  Future<int> _calcSize(Directory dir) async {
    int total = 0;
    await for (final entry in dir.list(recursive: true)) {
      if (entry is File) total += await entry.length();
    }
    return total;
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
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

    final dir = await getDownloadDirectory();
    await for (final entry in dir.list()) {
      if (entry is Directory) {
        final hasManga = await File('${entry.path}/manga.pb').exists();
        if (hasManga) await entry.delete(recursive: true);
      }
    }
    _loadDownloadInfo();
  }

  @override
  Widget build(BuildContext context) {
    final store = Store.getStoreInstance();
    _locale ??= FlutterI18n.currentLocale(context)?.languageCode;


    return Scaffold(
      appBar: AppBar(
        title: I18nText('settings.title'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: I18nText('settings.misc'),
            ),
            SwitchListTile(
              value: store.getDataSaver() ?? false,
              onChanged: (v) {
                store.setDataSaver(v);
                setState(() {});
              },
              title: I18nText('settings.data_saver'),
            ),
            ListTile(
              title: I18nText('settings.language'),
              trailing: DropdownButton<String>(
                  value: _locale,
                  items: languages
                      .map(
                        (locale) => DropdownMenuItem<String>(
                          value: locale.languageCode,
                          child: Text(locale.languageCode),
                        ),
                      )
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
                  }),
            ),
            ListTile(
              title: I18nText('settings.statistics.title'),
              onTap: () {
                Navigator.of(context).pushNamed('statistics');
              },
            ),
            ListTile(
              enabled: dotenv.env['GITHUB_TOKEN'] != null,
              title: I18nText('settings.check_update'),
              onTap: () async {
                final info = await PackageInfo.fromPlatform();

                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => UpdateDialog(packageInfo: info),
                  );
                }
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: I18nText('settings.download'),
            ),
            ListTile(
              title: I18nText('settings.download_directory'),
              subtitle: Text(_downloadDir ?? '…'),
              trailing: const Icon(Icons.folder_open),
              onTap: () async {
                final path = await getDirectoryPath();
                if (path == null) return;
                await Store.getStoreInstance().setDownloadDir(path);
                _loadDownloadInfo();
              },
              onLongPress: () async {
                await Store.getStoreInstance().clearDownloadDir();
                _loadDownloadInfo();
              },
            ),
            ListTile(
              title: Text(
                FlutterI18n.translate(context, 'settings.download_clear'),
                style: const TextStyle(color: Colors.red),
              ),
              subtitle: Text(_downloadSize ?? '…'),
              onTap: _clearDownloads,
            ),
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
                    children: [
                      Text(API.loggedIn.username),
                      Text(API.loggedIn.email),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: I18nText('settings.edit_account'),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                FlutterI18n.translate(context, 'settings.logout'),
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () async {
                Store.getStoreInstance().removeToken();
                API.token = null;
                if (!mounted) {
                  return;
                }
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('login');
              },
            ),
            ListTile(
              title: Text(
                FlutterI18n.translate(context, 'settings.remove_account'),
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

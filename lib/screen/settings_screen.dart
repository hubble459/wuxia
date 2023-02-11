import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/partial/dialog/update_dialog.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:package_info_plus/package_info_plus.dart';

const languages = [Locale('zh'), Locale('en')];

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _locale;

  @override
  Widget build(BuildContext context) {
    _locale ??= FlutterI18n.currentLocale(context)?.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: I18nText('settings.title'),
      ),
      body: SimpleFutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        onLoadedBuilder: (context, preferences) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: I18nText('settings.misc'),
              ),
              SwitchListTile(
                value: preferences.getBool('data_saver') ?? false,
                onChanged: (v) {
                  preferences.setBool('data_saver', v);
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

                        preferences.setString('language', locale!);
                        await FlutterI18n.refresh(context, Locale(locale));
                        await Jiffy.locale(locale);

                        if (mounted) {
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
                title: I18nText('settings.check_update'),
                onTap: () async {
                  final info = await PackageInfo.fromPlatform();

                  if (mounted) {
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
                subtitle: const Text('/blah/blah'),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  FlutterI18n.translate(context, 'settings.download_clear'),
                  style: const TextStyle(color: Colors.red),
                ),
                subtitle: const Text('1.2GB in use'),
                onTap: () {},
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
                  await const FlutterSecureStorage().delete(key: 'token');
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
      ),
    );
  }
}

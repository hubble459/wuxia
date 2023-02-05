import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/screen/root_nav_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText('settings.title'),
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _Settings(snapshot.requireData);
            } else {
              return Center(
                child: I18nText('error', translationParams: {
                  'error': snapshot.error?.toString() ?? FlutterI18n.translate(context, 'details.unknown'),
                }),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

const languages = [Locale('zh'), Locale('en')];

class _Settings extends StatefulWidget {
  final SharedPreferences preferences;

  const _Settings(this.preferences, {Key? key}) : super(key: key);

  @override
  State<_Settings> createState() => _SettingsState();
}

class _SettingsState extends State<_Settings> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: I18nText('settings.misc'),
          ),
          SwitchListTile(
            value: widget.preferences.getBool('data_saver') ?? false,
            onChanged: (v) {
              widget.preferences.setBool('data_saver', v);
              setState(() {});
            },
            title: I18nText('settings.data_saver'),
          ),
          ListTile(
            title: I18nText('settings.language'),
            trailing: DropdownButton<String>(
                value: FlutterI18n.currentLocale(context)!.languageCode,
                items: languages
                    .map(
                      (locale) => DropdownMenuItem<String>(
                        value: locale.languageCode,
                        child: Text(locale.languageCode),
                      ),
                    )
                    .toList(),
                onChanged: (locale) {
                  if (FlutterI18n.currentLocale(context)?.languageCode != locale) {
                    widget.preferences.setString('language', locale!);
                    FlutterI18n.refresh(context, Locale(locale));
                    Navigator.of(context).pop();
                    context.findRootAncestorStateOfType<State<RootNavScreen>>()?.setState(() {});
                  }
                }),
          ),
          ListTile(
            title: I18nText('settings.statistics.title'),
            onTap: () {
              Navigator.of(context).pushNamed('statistics');
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
    );
  }
}

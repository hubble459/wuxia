import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      bottomNavigationBar: MaterialButton(
        minWidth: double.infinity,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        color: Theme.of(context).colorScheme.error,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () async {
          await const FlutterSecureStorage().delete(key: 'token');
          if (!mounted) {
            return;
          }
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('login');
        },
        child: I18nText('settings.logout'),
      ),
    );
  }
}

// class Locale {
//   final String langCode;
//   final String language;

//   const Locale({required this.langCode, required this.language});
// }

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
            trailing: DropdownButton<Locale>(
                value: FlutterI18n.currentLocale(context),
                items: languages
                    .map(
                      (locale) => DropdownMenuItem<Locale>(
                        value: locale,
                        child: Text(locale.languageCode),
                      ),
                    )
                    .toList(),
                onChanged: (locale) {
                  widget.preferences.setString('language', locale!.languageCode);
                  FlutterI18n.refresh(context, locale);
                  Navigator.of(context).pop();
                  context.findRootAncestorStateOfType<State<RootNavScreen>>()?.setState(() {});
                  setState(() {});
                })),
      ],
    );
  }
}

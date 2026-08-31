import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/util/store.dart';
import 'package:wuxia/util/validator_builder.dart';

class ChangeAPIDialog extends StatefulWidget {
  const ChangeAPIDialog({super.key});

  @override
  State<ChangeAPIDialog> createState() => _ChangeAPIDialogState();
}

class _ChangeAPIDialogState extends State<ChangeAPIDialog> {
  final fkUrl = GlobalKey<FormState>();
  final TextEditingController _urlController = TextEditingController(text: api.getApiURL());
  String? _error;
  bool tested = false;

  @override
  void initState() {
    (() async {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      _setUrl(data);
    })();

    super.initState();
  }

  void _setUrl(ClipboardData? data) {
    if (data != null && data.text != null) {
      final url = Uri.tryParse(data.text!);
      if (url != null && url.hasScheme) {
        _urlController.text = url.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        FlutterI18n.translate(context, 'login.change_host'),
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 4.0),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      children: [
        Visibility(
          visible: _error != null,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              _error ?? '',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Form(
          key: fkUrl,
          child: TextFormField(
            controller: _urlController,
            validator: ValidatorBuilder.translate(context, 'basic.url').isHostWithPortUrl().build(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            onChanged: (value) => setState(() {
              tested = false;
              _error = null;
            }),
            decoration: InputDecoration(
                label: I18nText('basic.url'),
                isDense: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.restore),
                  onPressed: () async {
                    api.reset();
                    await Store.getStoreInstance().setApiHost(api.getApiURL());
                    _urlController.text = api.getApiURL();
                  },
                )),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            setState(() {
              _error = null;
            });

            if (fkUrl.currentState?.validate() == true) {
              final parsed = parseHostAndPort(_urlController.text)!;
              tested = await API.test(parsed.host, parsed.port);
              if (tested) {
                setState(() {});
                return;
              }
            }

            setState(() {
              _error = 'No Response!';
            });
          },
          child: I18nText('login.test_connection'),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondary),
          ),
          onPressed: tested
              ? () async {
                  if (fkUrl.currentState?.validate() == true) {
                    final parsed = parseHostAndPort(_urlController.text)!;
                    api = API(parsed.host, parsed.port);
                    await Store.getStoreInstance().setApiHost(api.getApiURL());
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                }
              : null,
          child: I18nText('basic.save'),
        ),
      ],
    );
  }
}

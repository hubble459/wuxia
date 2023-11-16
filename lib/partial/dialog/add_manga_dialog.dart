import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:grpc/grpc.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/util/validator_builder.dart';

class AddMangaDialog extends StatefulWidget {
  const AddMangaDialog({super.key});

  @override
  State<AddMangaDialog> createState() => _AddMangaDialogState();
}

class _AddMangaDialogState extends State<AddMangaDialog> {
  final TextEditingController _urlController = TextEditingController();
  String? _error;

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
      if (url != null) {
        _urlController.text = url.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        FlutterI18n.translate(context, 'reading.add_from_url'),
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
        TextFormField(
          controller: _urlController,
          validator: ValidatorBuilder.translate(context, 'basic.url').isUrl().build(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              label: I18nText('basic.url'),
              isDense: true,
              suffixIcon: IconButton(
                icon: const Icon(Icons.paste),
                onPressed: () async {
                  final data = await Clipboard.getData(Clipboard.kTextPlain);
                  _setUrl(data);
                },
              )),
        ),
        ElevatedButton(
          onPressed: () async {
            _error = null;
            try {
              final manga = await api.manga.findOrCreate(MangaRequest(
                url: _urlController.text,
              ));
              final reading = await api.reading.create(ReadingPostRequest(mangaId: manga.id));

              if (mounted) {
                Navigator.of(context).pop(reading);
              }
            } catch (e) {
              if (e is GrpcError) {
                setState(() {
                  _error = e.message;
                });
              }
            }
          },
          child: I18nText('basic.add'),
        )
      ],
    );
  }
}

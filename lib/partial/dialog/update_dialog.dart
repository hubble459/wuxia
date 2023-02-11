import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:github/github.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UpdateDialog extends StatefulWidget {
  final PackageInfo packageInfo;

  const UpdateDialog({super.key, required this.packageInfo});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  late final Future<Release> releaseFuture;
  final List<int> _bytes = [];
  late http.StreamedResponse _response;
  int _total = 0, _received = 0;
  File? _apk;
  bool isDownloading = false;

  String get currentVersion => 'Current v${widget.packageInfo.version}';

  @override
  void initState() {
    releaseFuture = GitHub(auth: Authentication.withToken(dotenv.env['GITHUB_TOKEN']))
        .repositories
        .getLatestRelease(RepositorySlug('hubble459', 'wuxia'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        FlutterI18n.translate(context, 'dialog.update.title'),
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 4.0),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      children: [
        Text(
          currentVersion,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        SimpleFutureBuilder<Release>(
          future: releaseFuture,
          onLoadedBuilder: (context, release) => Column(
            children: [
              Text(
                'Latest ${release.tagName}',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.secondary)),
                onPressed: currentVersion.endsWith(release.tagName!)
                    ? null
                    : isDownloading
                        ? null
                        : () async {
                            if ((await Permission.requestInstallPackages.request()).isGranted) {
                              final abi = Abi.current();

                              String? apkRelease;

                              switch (abi) {
                                case Abi.androidArm:
                                  apkRelease = 'wuxia-armeabi-v7a-release.apk';
                                  break;
                                case Abi.androidArm64:
                                  apkRelease = 'wuxia-arm64-v8a-release.apk';
                                  break;
                                case Abi.androidX64:
                                  apkRelease = 'wuxia-x86_64-release.apk';
                                  break;
                              }

                              if (apkRelease == null) {
                                // TODO show error
                                return;
                              }

                              final asset = release.assets?.firstWhere((element) => element.name == apkRelease);

                              if (asset == null) {
                                // TODO show error
                                return;
                              }

                              print(asset.browserDownloadUrl);

                              final downloadDir = await getDownloadPath();

                              if (downloadDir == null) {
                                // TODO show error
                                return;
                              }

                              setState(() {
                                isDownloading = true;
                              });

                              try {
                                await downloadFile(asset.browserDownloadUrl!, 'wuxia.apk');
                                setState(() {
                                  isDownloading = false;
                                });
                                await AppInstaller.installApk(_apk!.path);
                                // await _apk!.delete();
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                child: isDownloading
                    ? Text('${(_received / (1024 * 1000)).toStringAsFixed(2)}/${(_total / (1024 * 1000)).toStringAsFixed(2)} MB')
                    : I18nText('dialog.update.update'),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> downloadFile(String url, String fileName) async {
    _received = 0;
    _bytes.clear();
    _response = await http.Client().send(http.Request('GET', Uri.parse(url)));
    _total = _response.contentLength ?? 0;

    final completer = Completer();

    _response.stream.listen((value) {
      _bytes.addAll(value);
      setState(() {
        _received += value.length;
      });
    }).onDone(() async {
      final file = File('${(await getDownloadPath())}/$fileName');
      await file.writeAsBytes(_bytes);
      completer.complete();
      setState(() {
        _apk = file;
      });
    });

    return completer.future;
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      print('Cannot get download folder path');
    }
    return directory?.path;
  }
}

import 'dart:js_interop';

import 'package:web/web.dart' as web;

void onNotificationOpen(void Function(int mangaId) callback) {
  web.window.navigator.serviceWorker.addEventListener(
    'message',
    ((web.MessageEvent event) {
      final data = event.data.dartify();
      if (data is! Map || data['type'] != 'open-manga') return;
      final mangaId = int.tryParse('${data['mangaId']}');
      if (mangaId != null) callback(mangaId);
    }).toJS,
  );
}

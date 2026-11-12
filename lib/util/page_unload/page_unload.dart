import 'page_unload_io.dart' if (dart.library.js_interop) 'page_unload_web.dart' as impl;

/// Calls [callback] once the page starts unloading (a reload, closing the
/// tab, navigating away). Web only; a no-op on native platforms, where the
/// app isn't torn down like a page is.
void onPageUnload(void Function() callback) => impl.onPageUnload(callback);

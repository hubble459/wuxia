{{flutter_js}}
{{flutter_build_config}}

// CanvasKit comes from the app's own origin (not gstatic's CDN) so
// wuxia_sw.js can cache it for offline starts.
_flutter.loader.load({
  config: {
    canvasKitBaseUrl: 'canvaskit/',
  },
});

// The worker only starts controlling the page after this first load, so the
// files this load already fetched are handed to it to cache -- otherwise the
// app would only work offline after a second online visit.
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('wuxia_sw.js').catch((e) => {
    console.warn('Service worker registration failed:', e);
  });

  const sendLoadedFiles = async () => {
    const registration = await navigator.serviceWorker.ready;
    const urls = [location.href, ...performance.getEntriesByType('resource').map((e) => e.name)];
    registration.active?.postMessage({ type: 'cache-urls', urls });
  };
  window.addEventListener('flutter-first-frame', () => {
    sendLoadedFiles();
    // Fonts and assets requested right after the first frame.
    setTimeout(sendLoadedFiles, 5000);
  });
}

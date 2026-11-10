'use strict';

// Keeps the app shell (index, compiled Dart, CanvasKit, assets) available
// offline so downloaded manga can be read without a connection.
//
// Network-first: online visits always get the latest build and refresh the
// cache; the cache is only used when the network request fails. Only the
// app's own files are touched -- API calls (POST) and page images (other
// origins) pass straight through.

const CACHE = 'wuxia-shell-v1';
const SCOPE = new URL(self.registration.scope);
const CACHED_DIRS = ['assets/', 'canvaskit/', 'icons/'];
const SKIPPED = ['wuxia_sw.js', 'firebase-messaging-sw.js', 'flutter_service_worker.js'];

self.addEventListener('install', () => {
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    (async () => {
      for (const key of await caches.keys()) {
        if (key !== CACHE) await caches.delete(key);
      }
      await self.clients.claim();
    })(),
  );
});

function isShellUrl(url) {
  if (url.origin !== SCOPE.origin || !url.pathname.startsWith(SCOPE.pathname)) return false;

  const path = url.pathname.slice(SCOPE.pathname.length);
  if (SKIPPED.includes(path)) return false;
  // Files at the root of the app (main.dart.js, flutter_bootstrap.js, ...).
  if (!path.includes('/')) return true;
  return CACHED_DIRS.some((dir) => path.startsWith(dir));
}

function isShellRequest(request) {
  if (request.method !== 'GET') return false;
  if (request.mode === 'navigate') return true;
  return isShellUrl(new URL(request.url));
}

// Files the page loaded before this worker controlled it (see
// flutter_bootstrap.js). Mostly served from the HTTP cache, so cheap.
self.addEventListener('message', (event) => {
  if (event.data?.type !== 'cache-urls') return;
  event.waitUntil(
    (async () => {
      const cache = await caches.open(CACHE);
      for (const raw of event.data.urls) {
        const url = new URL(raw);
        const isPage = url.href === event.data.urls[0];
        if (!isPage && !isShellUrl(url)) continue;
        const key = isPage ? SCOPE.href : url.href;
        if (await cache.match(key, { ignoreSearch: true })) continue;
        try {
          const response = await fetch(url.href);
          if (response.ok) await cache.put(key, response);
        } catch (_) {}
      }
    })(),
  );
});

self.addEventListener('fetch', (event) => {
  const { request } = event;
  if (!isShellRequest(request)) return;

  event.respondWith(
    (async () => {
      const cache = await caches.open(CACHE);
      // Every route of the single-page app is served by the same index.html.
      const key = request.mode === 'navigate' ? SCOPE.href : request;
      try {
        const response = await fetch(request);
        if (response.ok) await cache.put(key, response.clone());
        return response;
      } catch (e) {
        const cached = await cache.match(key, { ignoreSearch: true });
        if (cached) return cached;
        throw e;
      }
    })(),
  );
});

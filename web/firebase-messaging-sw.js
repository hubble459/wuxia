// Opens the manga a tapped notification is about. Registered before Firebase loads,
// because Firebase's own click listener swallows the event and only opens a link the
// message carries, which rumgap's don't.
self.addEventListener("notificationclick", (event) => {
  const mangaId = event.notification.data?.FCM_MSG?.data?.manga_id;
  if (!mangaId) return;
  event.notification.close();
  event.waitUntil(openManga(mangaId));
});

// An open wuxia is told which manga to show (see lib/util/notification_open); this
// worker doesn't control its pages, so it can't navigate them. Otherwise wuxia is
// opened on the manga's deep link.
async function openManga(mangaId) {
  const app = new URL("./", self.location.href);
  const windows = await self.clients.matchAll({ type: "window", includeUncontrolled: true });
  const open = windows.find((client) => new URL(client.url).origin === app.origin);
  if (open) {
    await open.focus();
    open.postMessage({ type: "open-manga", mangaId });
    return;
  }
  await self.clients.openWindow(new URL(`#manga/${mangaId}`, app).href);
}

importScripts("https://www.gstatic.com/firebasejs/13.1.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/13.1.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyDpaoMPCk-W0D2DhPRb7LihffJE6BFl4GA",
  authDomain: "wuxia-6a4d2.firebaseapp.com",
  projectId: "wuxia-6a4d2",
  storageBucket: "wuxia-6a4d2.firebasestorage.app",
  messagingSenderId: "732960090044",
  appId: "1:732960090044:web:3ac3459a54652f80aaedb9",
  measurementId: "G-ML2X6PXHBJ",
});

// Firebase shows every push that has a notification part by itself, which is all of
// rumgap's, so nothing here shows one too (that would show each one twice).
firebase.messaging();

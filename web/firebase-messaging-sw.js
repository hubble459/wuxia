importScripts("https://www.gstatic.com/firebasejs/10.13.2/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.13.2/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyDpaoMPCk-W0D2DhPRb7LihffJE6BFl4GA",
  authDomain: "wuxia-6a4d2.firebaseapp.com",
  projectId: "wuxia-6a4d2",
  storageBucket: "wuxia-6a4d2.firebasestorage.app",
  messagingSenderId: "732960090044",
  appId: "1:732960090044:web:3ac3459a54652f80aaedb9",
  measurementId: "G-ML2X6PXHBJ",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  const notificationTitle = payload.notification?.title ?? "wuxia";
  const notificationOptions = {
    body: payload.notification?.body,
    icon: "icons/Icon-192.png",
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});

import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/main.dart';
import 'package:wuxia/partial/dialog/add_manga_dialog.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/screen/downloads_screen.dart';
import 'package:wuxia/screen/latest_screen.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';
import 'package:wuxia/screen/reading_screen.dart';
import 'package:wuxia/screen/search_screen.dart';
import 'package:wuxia/util/app_routes.dart';
import 'package:wuxia/util/session.dart';

class Route {
  final IconData icon;
  final String label;
  final Widget widget;

  const Route({required this.icon, required this.label, required this.widget});
}

class RootNavScreen extends StatefulWidget {
  const RootNavScreen({super.key});

  @override
  State<RootNavScreen> createState() => _RootNavScreenState();
}

class _RootNavScreenState extends State<RootNavScreen> {
  final PageController _pageController = PageController();
  int stateChange = 0;
  int _selected = 0;

  // A web deep link (or page refresh) can land here directly, skipping
  // SplashScreen -- the only place credentials used to get restored. Redo
  // that restore here too (it's a no-op if Splash already ran it) before
  // showing anything that depends on API.loggedIn.
  bool _ready = false;

  Future<void> _bootstrap() async {
    await restoreSession();
    if (!mounted) return;

    if (!API.isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('login');
      return;
    }

    setState(() => _ready = true);
    _initNotificationHandler();
  }

  Future<void> _handleNotificationInForeground(RemoteMessage message) async {
    final mangaId = message.data['manga_id'];

    if (mangaId is String) {
      final manga = await api.manga.get(GetMangaRequest(id: int.parse(mangaId)));

      final context = navigatorKey.currentState?.context;
      if (context == null || context.mounted != true) {
        return;
      }

      Fluttertoast.showToast(
        msg: FlutterI18n.translate(context, 'notification.new_chapter', translationParams: {'title': manga.title}),
        timeInSecForIosWeb: 5,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> _handleNotificationClick(RemoteMessage message) async {
    final mangaId = message.data['manga_id'];

    if (mangaId is String) {
      final manga = await api.manga.get(GetMangaRequest(id: int.parse(mangaId)));
      final context = navigatorKey.currentState?.context;

      if (context?.mounted == true) {
        Navigator.of(context!).push(MaterialPageRoute(
          settings: RouteSettings(name: mangaRouteName(manga.id)),
          builder: (context) => MangaScreen(
            manga: manga,
            type: HeroScreenType.reading,
          ),
        ));
      }
    }
  }

  Future<void> _initNotificationHandler() async {
    if (!kIsWeb && Platform.isLinux) {
      return;
    }

    try {
      final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);

      if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
        return;
      }

      final token = await FirebaseMessaging.instance.getToken(vapidKey: dotenv.env['VAPID_KEY']);

      print('FCM Token: $token');
      if (!API.loggedIn.deviceIds.contains(token)) {
        await api.user.addDeviceToken(DeviceTokenRequest(token: token));
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
        if (!API.loggedIn.deviceIds.contains(fcmToken)) {
          print('Updating FCM Device Token');
          await api.user.removeDeviceToken(DeviceTokenRequest(token: token));
          await api.user.addDeviceToken(DeviceTokenRequest(token: fcmToken));
        }
      }).onError((err) {
        // UHHHHH
        print(err);
      });

      final message = await FirebaseMessaging.instance.getInitialMessage();
      if (message != null) {
        _handleNotificationClick(message);
      }

      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationClick);

      FirebaseMessaging.onMessage.listen(_handleNotificationInForeground);
    } catch (err) {
      print('Failed to set up push notifications: $err');

      final context = navigatorKey.currentState?.context;
      if (context != null && context.mounted) {
        Fluttertoast.showToast(
          msg: FlutterI18n.translate(context, 'notification.push_unavailable'),
          timeInSecForIosWeb: 5,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _bootstrap();
  }

  static const _wideBreakpoint = 700.0;

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final routes = <Route>[
      Route(label: FlutterI18n.translate(context, 'nav.reading'), icon: Icons.my_library_books, widget: const ReadingScreen()),
      Route(label: FlutterI18n.translate(context, 'nav.latest'), icon: Icons.whatshot, widget: const LatestScreen()),
      Route(label: FlutterI18n.translate(context, 'nav.search'), icon: Icons.search, widget: const SearchScreen()),
      if (!kIsWeb)
        Route(label: FlutterI18n.translate(context, 'nav.downloads'), icon: Icons.download, widget: const DownloadsScreen()),
    ];
    final isWide = MediaQuery.sizeOf(context).width >= _wideBreakpoint;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(routes[_selected].label),
          actions: [
            ...(_selected == 0
                ? [
                    IconButton(
                      onPressed: () async {
                        final reading = await showDialog<MangaReply>(
                          context: context,
                          builder: (context) => const AddMangaDialog(),
                        );
                        if (reading != null && context.mounted) {
                          setState(() {
                            stateChange++;
                          });

                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              settings: RouteSettings(name: mangaRouteName(reading.id)),
                              builder: (context) => MangaScreen(
                                manga: reading,
                                type: HeroScreenType.reading,
                              ),
                            ),
                          );

                          if (mounted) {
                            setState(() {
                              stateChange++;
                            });
                          }
                        }
                      },
                      tooltip: FlutterI18n.translate(context, 'basic.add'),
                      icon: const Icon(Icons.add),
                    ),
                  ]
                : []),
            IconButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('settings');
                if (mounted) {
                  setState(() {
                    stateChange++;
                  });
                }
              },
              tooltip: FlutterI18n.translate(context, 'settings.title'),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: SafeArea(
          child: Row(
            children: [
              if (isWide)
                NavigationRail(
                  labelType: NavigationRailLabelType.all,
                  selectedIndex: _selected,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selected = index;
                      _pageController.jumpToPage(_selected);
                    });
                  },
                  destinations: routes
                      .map((route) => NavigationRailDestination(
                            icon: Icon(route.icon),
                            label: Text(route.label),
                          ))
                      .toList(),
                ),
              if (isWide) const VerticalDivider(width: 1),
              Expanded(
                // The tabs stay mounted (AutomaticKeepAliveClientMixin) to
                // preserve scroll position across switches, so more than one
                // is in the tree at once with only the active one actually
                // laid out. The app-wide SelectionArea tries to sort every
                // selectable across all of them by screen position, which
                // crashes on the ones that were never laid out -- opt this
                // whole area out of selection to avoid it.
                child: SelectionContainer.disabled(
                  child: PageView(
                    key: Key(stateChange.toString()),
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: routes.map((e) => e.widget).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: isWide
            ? null
            : BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: routes
                    .map((route) => BottomNavigationBarItem(
                          icon: Icon(route.icon),
                          label: route.label,
                        ))
                    .toList(),
                currentIndex: _selected,
                onTap: (index) {
                  setState(() {
                    _selected = index;
                    _pageController.jumpToPage(_selected);
                  });
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }
}

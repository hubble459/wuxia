import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/manga.pb.dart';
import 'package:wuxia/gen/rumgap.pb.dart';
import 'package:wuxia/gen/user.pb.dart';
import 'package:wuxia/main.dart';
import 'package:wuxia/partial/dialog/add_manga_dialog.dart';
import 'package:wuxia/partial/list/manga_item.dart';
import 'package:wuxia/screen/latest_screen.dart';
import 'package:wuxia/screen/manga/manga_screen.dart';
import 'package:wuxia/screen/reading_screen.dart';
import 'package:wuxia/screen/search_screen.dart';

class Route {
  final IconData icon;
  final String label;
  final Widget widget;

  const Route({required this.icon, required this.label, required this.widget});
}

class RootNavScreen extends StatefulWidget {
  const RootNavScreen({Key? key}) : super(key: key);

  @override
  State<RootNavScreen> createState() => _RootNavScreenState();
}

class _RootNavScreenState extends State<RootNavScreen> {
  final PageController _pageController = PageController();
  int stateChange = 0;
  int _selected = 0;

  _initNotificationHandler() async {
    final token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');
    if (!API.loggedIn.deviceIds.contains(token)) {
      await api.user.addDeviceToken(DeviceTokenRequest(token: token));
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.onTokenRefresh.listen((fcmToken) async {
      if (!API.loggedIn.deviceIds.contains(fcmToken)) {
        print('Updating FCM Device Token');
        await api.user.removeDeviceToken(DeviceTokenRequest(token: token));
        await api.user.addDeviceToken(DeviceTokenRequest(token: fcmToken));
      }
    }).onError((err) {
      // UHHHHH
      print(err);
    });

    FirebaseMessaging.onMessage.listen((message) async {
      final mangaId = message.data['manga_id'] ?? null;

      if (mangaId is String) {
        final manga = await api.manga.get(Id(id: int.parse(mangaId)));

        Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
          builder: (context) => MangaScreen(
            manga: manga,
            type: HeroScreenType.reading,
          ),
        ));
      }
    });
  }

  @override
  void initState() {
    _initNotificationHandler();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routes = <Route>[
      Route(label: FlutterI18n.translate(context, 'nav.reading'), icon: Icons.my_library_books, widget: const ReadingScreen()),
      Route(label: FlutterI18n.translate(context, 'nav.latest'), icon: Icons.whatshot, widget: const LatestScreen()),
      Route(label: FlutterI18n.translate(context, 'nav.search'), icon: Icons.search, widget: const SearchScreen()),
    ];

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
          child: PageView(
            key: Key(stateChange.toString()),
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: routes.map((e) => e.widget).toList(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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

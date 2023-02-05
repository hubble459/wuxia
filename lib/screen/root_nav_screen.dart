import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/screen/latest_screen.dart';
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
  int _selected = 0;

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
          title: I18nText('title'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('settings').then((value) {
                  if (context.mounted) {
                    setState(() {});
                  }
                });
              },
              tooltip: FlutterI18n.translate(context, 'settings.title'),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: SafeArea(
          child: PageView(
            key: Key(FlutterI18n.currentLocale(context)?.languageCode ?? 'root'),
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: routes.map((e) => e.widget).toList(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: routes.map((route) => BottomNavigationBarItem(icon: Icon(route.icon), label: route.label)).toList(),
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

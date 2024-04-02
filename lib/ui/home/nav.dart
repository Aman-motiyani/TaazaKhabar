import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taazakhabar/modules/news/infrastructure/repos/news_repository.dart';
import 'package:taazakhabar/modules/news/infrastructure/services/news_service.dart';
import 'package:taazakhabar/modules/news/presentation/ui/pages/fav_screen.dart';
import 'package:taazakhabar/modules/news/presentation/ui/pages/feed_screen.dart';
import 'package:taazakhabar/modules/news/presentation/ui/pages/saved_screen.dart';
import 'package:taazakhabar/modules/weather/infrastructure/repos/weather_repository.dart';
import 'package:taazakhabar/modules/weather/infrastructure/services/weather_service.dart';
import 'package:taazakhabar/ui/settings/settings.dart';


class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _BottomNavState();
}

class _BottomNavState extends State<NavigationScreen> {
  late final NewsRepository newsRepository;
  late final WeatherRepository weatherRepository;

  @override
  void initState() {
    super.initState();
    final NewsService apiService = NewsService.create();
    newsRepository = NewsRepository(apiService);
    final WeatherService weatherService = WeatherService.create();
    weatherRepository = WeatherRepository(weatherService);
  }

  // Define a list of tab titles
  final List<String> tabTitles = [
    'Feed',
    'Fav',
    'Saved',
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme col = Theme.of(context).colorScheme;
    // Define a map to associate tab titles with widgets
    final Map<String, Widget> pages = {
      'Feed': FeedScreen(),
      'Fav': FavScreen(),
      'Saved': SavedScreen(),
    };

    return WillPopScope(
      onWillPop: () async {
        // Show an AlertDialog to confirm exiting the app
        bool exit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Stay in the app
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),// Exit the app
                child: Text('Yes'),
              ),
            ],
          ),
        );

        // Return true if the user wants to exit, false otherwise
        return exit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: SizedBox(),
          title: Text("Taaza Khabar" , style: TextStyle(color: col.onSecondaryContainer ,fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const Settings()));
              },
              icon:  Icon(Icons.settings , color: col.onSecondaryContainer),
            ),
          ],
        ),
        body: pages[tabTitles[_selectedIndex]],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: 'Fav',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.save),
              label: 'Saved',
            ),
          ],
        ),
      ),
    );
  }
}

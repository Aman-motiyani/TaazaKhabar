import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_bloc.dart';
import 'package:taazakhabar/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:taazakhabar/blocs/weather_bloc/weather_bloc.dart';
import 'package:taazakhabar/ui/screens/home/pages/fav_screen.dart';
import 'package:taazakhabar/ui/screens/home/pages/feed_screen.dart';
import 'package:taazakhabar/ui/screens/home/pages/saved_screen.dart';
import 'package:taazakhabar/ui/screens/home/settings.dart';

import '../../../data/repository/news_repository.dart';
import '../../../data/repository/weather_repository.dart';
import '../../../services/news_service.dart';
import '../../../services/weather_service.dart';

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
    // Define a map to associate tab titles with widgets
    final Map<String, Widget> pages = {
      'Feed': BlocProvider(
        create: (context) => NewsBloc(newsRepository),
        child: BlocProvider(
          create: (context) => WeatherBloc(weatherRepository),
          child: BlocProvider(
            create: (context) => OnboardingBloc(),
            child: FeedScreen(),
          ),
        ),
      ),
      'Fav': BlocProvider(
        create: (context) => NewsBloc(newsRepository),
        child: FavScreen(),
      ),
      'Saved': SavedScreen(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Taaza Khabar"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings(onboardingBloc: OnboardingBloc(),),),
              );
            },
            icon: const Icon(Icons.settings),
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
    );
  }
}

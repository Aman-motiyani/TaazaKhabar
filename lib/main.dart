import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taazakhabar/blocs/news_bloc/news_bloc.dart';
import 'package:taazakhabar/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:taazakhabar/blocs/weather_bloc/weather_bloc.dart';
import 'package:taazakhabar/services/local_database/isar_database.dart';
import 'package:taazakhabar/services/news_service.dart';
import 'package:taazakhabar/services/weather_service.dart';
import 'package:taazakhabar/ui/screens/home/nav.dart';
import 'package:taazakhabar/ui/screens/onboarding/name_input_screen.dart.dart';

import 'data/repository/news_repository.dart';
import 'data/repository/weather_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.openDB();
  bool isFirstLaunch = await _checkFirstLaunch();
  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

Future<bool> _checkFirstLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
  if (isFirstLaunch) {
    prefs.setBool('firstLaunch', false);
  }
  return isFirstLaunch;
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  MyApp({required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    final NewsService apiService = NewsService.create();
    final newsRepository = NewsRepository(apiService);
    final WeatherService weatherService = WeatherService.create();
    final weatherRepository = WeatherRepository(weatherService);

    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(weatherRepository),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(newsRepository),
        ),
        BlocProvider<OnboardingBloc>(
          create: (context) => OnboardingBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.brown, brightness: Brightness.light
          ),
          useMaterial3: true,
          fontFamily: 'SF Pro Display',
        ),
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
          fontFamily: 'SF Pro Display',
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.brown, brightness: Brightness.dark
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Taaza Khabar',
        home: isFirstLaunch
           ?  NameScreen()
            : NavigationScreen()
      ),
    );
  }
}

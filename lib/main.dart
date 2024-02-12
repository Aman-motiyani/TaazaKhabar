import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:taazakhabar/blocs/news_bloc/news_bloc.dart';
import 'package:taazakhabar/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:taazakhabar/blocs/weather_bloc/weather_bloc.dart';
import 'package:taazakhabar/data/repository/news_repository.dart';
import 'package:taazakhabar/data/repository/weather_repository.dart';
import 'package:taazakhabar/services/local_database/isar_database.dart';

import 'package:taazakhabar/services/news_service.dart';
import 'package:taazakhabar/services/weather_service.dart';
import 'package:taazakhabar/ui/screens/home/nav.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.openDB();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static NewsService apiService = NewsService.create();
  final NewsRepository newsRepository =
  NewsRepository(apiService);

  static WeatherService weatherService = WeatherService.create();
  final WeatherRepository weatherRepository = WeatherRepository(weatherService);

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taaza Khabar',
      home:  BlocProvider(
        create: (context) => NewsBloc(newsRepository), // Instantiate ChopperService instead of ApiService
        child: BlocProvider(
          create: (context) => WeatherBloc(weatherRepository),
          child : BlocProvider(
              create: (context) => OnboardingBloc(),
              child : NavigationScreen(),
          )
        )
      ),
    );
  }
}

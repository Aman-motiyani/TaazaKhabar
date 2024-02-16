import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_event.dart';
import 'package:taazakhabar/blocs/news_bloc/news_state.dart';
import 'package:taazakhabar/blocs/weather_bloc/weather_bloc.dart';
import 'package:taazakhabar/data/models/news_model.dart';
import 'package:taazakhabar/ui/widgets/news_card.dart';
import '../../../../blocs/onboarding_bloc/onboarding_bloc.dart';
import '../../../../data/models/weather_model.dart';
import '../../../../services/local_database/entities/local_news.dart';
import '../../../../services/local_database/isar_database.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late String name;
  // final controller = Get.find<OnboardingController>();
  final IsarService _isarService = IsarService();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OnboardingBloc>(context).loadFromSharedPreferences();
    BlocProvider.of<NewsBloc>(context).add(FetchNews());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        print(state);
        if (state is DataLoaded) {
          print("focus ${state.name}");
          print("focus ${state.cityName}");
          name = state.name;
          print(state.selectedCategories);
          BlocProvider.of<WeatherBloc>(context).add(FetchWeather(state.cityName));
        }

        return Scaffold(
          body: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, newsState) {
              return BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, weatherState) {
                  return _buildContent(newsState, weatherState);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildContent(NewsState state , WeatherState weatherState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: weatherState is WeatherLoaded
                ? _buildGreetingAndWeather(weatherState.weather)
                : weatherState is WeatherLoading
                ? _buildLoading()
                : const Center(child: Text("Can't Get Weather Information"))
        ),
        SizedBox(height: 16),
        Expanded(
            child: state is NewsLoaded
                ? _buildNewsList(state.newsList)
                : state is NewsLoading
                ? _buildLoading()
                : Center(child: Text("Can't get News Information"))
        ),
      ],
    );
  }

  Widget _buildGreetingAndWeather(WeatherModel weather) {
    final currentTime = DateTime.now();
    String greeting;
    if (currentTime.hour < 12) {
      greeting = 'Good morning';
    } else if (currentTime.hour < 18) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }
    final ColorScheme col = Theme.of(context).colorScheme;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '$greeting, $name ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: col.primary),
                ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      'Weather Condition: ${weather.weather[0].main}',
                      style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Temperature: ${weather.main.temp} celsius',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsList(List<NewsModel> newsList) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        return NewsCard(onPressed: () async {
          try{
            final localNews = LocalNews()
              ..title = news.title
              ..description = news.description
              ..publishedAt = news.publishedAt;

            final isSaved = await _isarService.saveNews(localNews);
            if (isSaved) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(backgroundColor: Colors.green,content: Text("News saved" ,style: TextStyle(color: Colors.white)), duration: Duration(seconds: 2)),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(
                      "News already saved",
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(seconds: 2)
                ),
              );
            }
          }
          catch(e){
            print("Error Saving news $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.redAccent,
                  content:
                  Text(
                    "Error Saving News",
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 2)
              ),
            );
          }
        },
          icon: Icons.save_alt_outlined,news: news,);
      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}


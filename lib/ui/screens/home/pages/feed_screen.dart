import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_event.dart';
import 'package:taazakhabar/blocs/news_bloc/news_state.dart';
import 'package:taazakhabar/blocs/weather_bloc/weather_bloc.dart';
import 'package:taazakhabar/data/models/news_model.dart';
import 'package:taazakhabar/ui/screens/home/newsdetail.dart';

import '../../../../blocs/onboarding_bloc/onboarding_bloc.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/models/weather_model.dart';
import '../../../../services/local_database/entities/local_news.dart';
import '../../../../services/local_database/isar_database.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final IsarService _isarService = IsarService();
  final city = "bengaluru";

  @override
  void initState() {
    super.initState();
    // Dispatch the FetchNews event when the widget is initialized
    BlocProvider.of<NewsBloc>(context).add(FetchNews());
    BlocProvider.of<WeatherBloc>(context).add(FetchWeather(city));
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, newsState) {
        return BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, weatherState) {
            return BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, onboardingState) {
                final userProfile = OnboardingBloc().userProfile;
                return Scaffold(
                  body: _buildContent(newsState, weatherState, userProfile),
                );
              },
            );
          },
        );
      },
    );
  }




  Widget _buildContent(NewsState state , WeatherState weatherState,UserProfile userProfile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: weatherState is WeatherLoaded
                ? _buildGreetingAndWeather(weatherState.weather , userProfile.username)
                : weatherState is WeatherLoading
                ? _buildLoading()
                : const Center(child: Text("Cant Get Weather Information"))
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

  Widget _buildGreetingAndWeather(WeatherModel weather, String username) {
    final currentTime = DateTime.now();
    String greeting;
    if (currentTime.hour < 12) {
      greeting = 'Good morning';
    } else if (currentTime.hour < 18) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }
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
                '$greeting, Aman',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    // Weather widget
                    // Replace this with your weather widget implementation
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
        return  Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                   Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(news: news),));},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    news.title,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500
                                    ),
                                    maxLines: 1, // Display title in one line
                                    overflow: TextOverflow.ellipsis, // Show ellipsis (...) if the title exceeds one line
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    news.description,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold
                                    ),
                                    maxLines: 4, // Display description in three lines
                                    overflow: TextOverflow.ellipsis, // Show ellipsis (...) if the description exceeds three lines
                                  ),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(width: 2),
                        SizedBox(width: 2,),
                        IconButton(
                            onPressed: () async {
                              final localNews = LocalNews()
                                ..title = news.title
                                ..description = news.description
                                ..publishedAt = news.publishedAt;

                              // Save the news using IsarService
                              await _isarService.saveNews(localNews);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("News saved")),
                              );
                            },
                            icon: Icon(Icons.save_alt_outlined)
                        ),
                      ],
                    ),
                ],
              ),
            ),
        );

      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

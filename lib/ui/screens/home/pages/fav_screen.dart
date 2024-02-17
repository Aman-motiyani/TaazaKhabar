import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taazakhabar/blocs/news_bloc/news_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_event.dart';
import 'package:taazakhabar/blocs/news_bloc/news_state.dart';
import 'package:taazakhabar/data/models/news_model.dart';

import '../../../../blocs/onboarding_bloc/onboarding_bloc.dart';
import '../../../../services/local_database/entities/local_news.dart';
import '../../../../services/local_database/isar_database.dart';
import '../../../widgets/news_card.dart';


class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}
class _FavScreenState extends State<FavScreen> {
  final IsarService _isarService = IsarService();
  late String selectedCategory = ''; // Initialize to empty string

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        List<String> selectedCategories = [];
        if (state is DataLoaded) {
          selectedCategories = state.selectedCategories;
          if (selectedCategories.isNotEmpty && selectedCategory.isEmpty) {
            // Set the selected category to the first item in the list
            selectedCategory = selectedCategories.first;
            // Fetch news for the selected category
            _fetchFavNewsByCategory(selectedCategory);
          }
        }
        return Scaffold(
          body: _buildCategoryDropdown(selectedCategories),
        );
      },
    );
  }

  Widget _buildCategoryDropdown(List<String> selectedCategories) {
    final ColorScheme col = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Category : ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: col.primary),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(2))),
                        child: DropdownButtonFormField<String>(
                          value: selectedCategory,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategory = newValue!;
                            });
                            _fetchFavNewsByCategory(newValue!);
                          },
                          items: selectedCategories
                              .map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is NewsLoaded) {
                  return _buildNewsList(state.newsList);
                } else if (state is NewsError) {
                  return const Center(child: Text("Can't Get News Information"));
                }
                return SizedBox(); // Placeholder
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList(List<NewsModel> newsList) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        return NewsCard(
          onPressed: () async {
            List<int> imageData;
            try{
              imageData = await _isarService.getImageBytes(news.urlToImage);
              final localNews = LocalNews()
                ..title = news.title
                ..imageBytes = imageData
                ..description = news.description
                ..publishedAt = news.publishedAt;

              final isSaved = await _isarService.saveNews(localNews);
              if (isSaved) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "News saved",
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 2),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(
                    "News already saved",
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 2),
                ));
              }
            } catch (e) {
              print("Error Saving news $e");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Error Saving News",
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(seconds: 2),
              ));
            }
          },
          icon: Icons.save_alt_outlined,
          news: news,
        );
      },
    );
  }

  void _fetchFavNewsByCategory(String category) {
    BlocProvider.of<NewsBloc>(context).add(FetchFavNews(category));
  }
}








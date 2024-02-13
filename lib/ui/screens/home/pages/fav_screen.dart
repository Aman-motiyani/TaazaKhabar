import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_event.dart';
import 'package:taazakhabar/blocs/news_bloc/news_state.dart';
import 'package:taazakhabar/data/models/news_model.dart';

import '../../../../services/local_database/entities/local_news.dart';
import '../../../../services/local_database/isar_database.dart';
import '../../../widgets/news_card.dart';
import '../newsdetail.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  late String _selectedCategory;
  final IsarService _isarService = IsarService();

  @override
  void initState() {
    super.initState();
    _selectedCategory = categories.first; // Initialize selected category
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCategoryDropdown(),
    );
  }

  Widget _buildCategoryDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Select Category : "),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2))

              ),
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                  _fetchFavNewsByCategory(newValue!);
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
                  return Center(child: Text(state.message));
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

  void _fetchFavNewsByCategory(String category) {
    BlocProvider.of<NewsBloc>(context).add(FetchFavNews(category));
  }
}

// Dummy list of categories (replace with your actual categories)
List<String> categories = ['Technology', 'Sports', 'Entertainment', 'Business'];

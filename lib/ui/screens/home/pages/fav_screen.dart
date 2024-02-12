import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_event.dart';
import 'package:taazakhabar/blocs/news_bloc/news_state.dart';
import 'package:taazakhabar/data/models/news_model.dart';

import '../newsdetail.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  late String _selectedCategory;

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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Select Category : "),
          Container(
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
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(news: news),));},
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
                            SizedBox(height: 4),
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
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved")));
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

  void _fetchFavNewsByCategory(String category) {
    BlocProvider.of<NewsBloc>(context).add(FetchFavNews(category));
  }
}

// Dummy list of categories (replace with your actual categories)
List<String> categories = ['Politics', 'Sports', 'Entertainment', 'Business'];

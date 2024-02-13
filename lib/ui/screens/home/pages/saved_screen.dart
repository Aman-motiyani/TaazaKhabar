import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/ui/screens/home/newsdetail.dart';
import 'package:taazakhabar/ui/widgets/news_card.dart';


import '../../../../blocs/localnews_bloc/local_news_bloc.dart';
import '../../../../blocs/localnews_bloc/local_news_event.dart';
import '../../../../blocs/localnews_bloc/local_news_state.dart';
import '../../../../data/models/news_model.dart';
import '../../../../services/local_database/isar_database.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalNewsBloc(IsarService())..add(LoadSavedNews()),
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Saved News :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: _buildNewsList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return BlocBuilder<LocalNewsBloc, LocalNewsState>(
      builder: (context, state) {
        if (state is LocalNewsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LocalNewsLoaded) {
          if (state.savedNews.isEmpty) {
            return Center(
              child: Text(
                'No saved news items',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.savedNews.length,
              itemBuilder: (context, index) {
                final news = state.savedNews[index];
                if (news != null) {
                  return NewsCard(
                    icon: Icons.delete,
                    onPressed: () {
                      BlocProvider.of<LocalNewsBloc>(context)
                          .add(DeleteNews(news.id));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.redAccent,
                          content: Text("News Deleted from Saved", style: TextStyle(color: Colors.white)), duration: Duration(seconds: 2)));
                    },
                    localNews: news,
                  );
                } else {
                  return Text("No data"); // Or you can show a loading indicator or placeholder
                }
              },
            );
          }
        } else {
          return Text("Error loading news");
        }
      },
    );
  }

}

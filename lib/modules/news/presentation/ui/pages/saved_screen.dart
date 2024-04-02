import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/modules/news/presentation/ui/widgets/news_card.dart';
import 'package:taazakhabar/modules/offline_news/application/localnews_bloc/local_news_bloc.dart';
import 'package:taazakhabar/modules/offline_news/application/localnews_bloc/local_news_event.dart';
import 'package:taazakhabar/modules/offline_news/application/localnews_bloc/local_news_state.dart';
import 'package:taazakhabar/modules/offline_news/infrastructure/service/isar_database.dart';
class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    final IsarService _isarService = IsarService();
    final ColorScheme col = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => LocalNewsBloc(IsarService())..add(LoadSavedNews()),
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          'Saved News :',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: col.primary),
                        ),
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
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
        print(state);
        if (state is LocalNewsLoading) {
          return const Center(child: CircularProgressIndicator());
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
                    localNews: news,
                    icon: Icons.delete,
                    onPressed: () {
                      BlocProvider.of<LocalNewsBloc>(context)
                          .add(DeleteNews(news.id));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.redAccent,
                          content: Text("News Deleted from Saved", style: TextStyle(color: Colors.white)), duration: Duration(seconds: 2)));
                    },
                  );
                } else {
                  return Text("No data"); // Or you can show a loading indicator or placeholder
                }
              },
            );
          }
        } else {
          return Center(child: Text("Error loading news"));
        }
      },
    );
  }
}

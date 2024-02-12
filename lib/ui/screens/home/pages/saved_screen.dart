import 'package:flutter/material.dart';
import '../../../../services/local_database/entities/local_news.dart';
import '../../../../services/local_database/isar_database.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final isarService = IsarService();
  late List<LocalNews?> _savedNews = []; // Declare _savedNews here

  @override
  void initState() {
    super.initState();
    _loadSavedNews();
  }

  Future<void> _loadSavedNews() async {
//
    final savedNews = await isarService.getAllSavedNews([1,2,3,4,5,6,7,8]);
    setState(() {
      _savedNews = savedNews;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget _buildNewsList() {
    return ListView.builder(
      itemCount: _savedNews.length,
      itemBuilder: (context, index) {
        final news = _savedNews[index];
        if (news != null) {
          return ListTile(
            title: Text(news.title),
            subtitle: Text(news.description),
            leading: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                isarService.deleteNews(index);
                setState(() {

                });
              },
            ),
            onTap: () {
              // Handle tapping on news item
            },
          );
        } else {
          return SizedBox(); // Or you can show a loading indicator or placeholder
        }
      },
    );
  }
}


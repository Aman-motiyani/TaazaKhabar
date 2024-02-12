import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taazakhabar/data/models/news_model.dart';

class NewsDetailScreen extends StatelessWidget{
  final NewsModel news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    String publishedAt = news.publishedAt;
    List<String> parts = publishedAt.split('T');

    String date = parts[0]; // Contains the date part
    String time = parts[1].substring(0, 5);

    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      time,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    // Share news functionality
                  },
                  icon: Icon(Icons.share),
                ),
                IconButton(
                  onPressed: () {
                    // Save or delete news functionality
                  },
                  icon: Icon(Icons.save_alt),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (news.urlToImage.isNotEmpty)
              Image.network(
                news.urlToImage,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            Text(
              news.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Share news functionality
        },
        child: Icon(Icons.open_in_browser),
      ),
    );
  }
}
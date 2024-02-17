import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taazakhabar/data/models/news_model.dart';
import 'package:taazakhabar/services/local_database/entities/local_news.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/local_database/isar_database.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsModel? news;
  final LocalNews? localNews;

  const NewsDetailScreen({Key? key, this.news, this.localNews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = localNews?.title ?? news!.title;
    final String description = localNews?.description ?? news!.description;
    final String publishedAt = localNews?.publishedAt ?? news!.publishedAt;
    final Uri url = Uri.parse(news?.url ?? '');
    final List<String> parts = publishedAt.split('T');
    final String date = parts.first;
    final String time = parts.last.substring(0, 5);
    final Uint8List image = Uint8List.fromList(localNews?.imageBytes ?? []);
    print(localNews?.imageBytes);
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
              title,
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
                localNews == null ? IconButton(
                  onPressed: () {
                    Share.shareUri(url);
                  },
                  icon: Icon(Icons.share),
                ) : SizedBox(), // If localNews is not null, hide the share button
                localNews == null ? IconButton(
                  onPressed: () async {
                    await launchUrl(url);
                  },
                  icon: Icon(Icons.open_in_browser),
                ) : SizedBox(), // If localNews is not null, hide the open in browser button
              ],
            ),

            SizedBox(height: 16),
            news != null ? Image.network(
                news!.urlToImage,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,)
            : image.isNotEmpty ?
            Image.memory(
              image,
              fit: BoxFit.cover,
            ):SizedBox(),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

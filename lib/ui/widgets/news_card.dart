import 'package:flutter/material.dart';
import 'package:taazakhabar/data/models/news_model.dart';

import '../../services/local_database/entities/local_news.dart';
import '../screens/home/newsdetail.dart';

class NewsCard extends StatelessWidget {
  final LocalNews? localNews;
  final NewsModel? news;
  final VoidCallback onPressed;
  final IconData icon;

  const NewsCard({
    required this.onPressed,
    this.localNews,
    this.news,
    Key? key, required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = localNews != null ? localNews!.title : news!.title;
    final String description = localNews != null ? localNews!.description : news!.description;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(news: news!)));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                IconButton(
                  onPressed: onPressed,
                  icon: Icon(icon),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

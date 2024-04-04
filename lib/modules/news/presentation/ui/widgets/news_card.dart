import 'package:flutter/material.dart';
import 'package:taazakhabar/modules/news/domain/models/news_model.dart';
import 'package:taazakhabar/modules/news/presentation/ui/widgets/newsdetail.dart';
import 'package:taazakhabar/modules/offline_news/domain/models/local_news.dart';



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
    final ColorScheme col = Theme.of(context).colorScheme;
    final String title = localNews != null ? localNews!.title : news!.title;
    final String description = localNews != null ? localNews!.description : news!.description;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: col.surfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
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
                          if (news!=null)
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                NewsDetailScreen( news : news,
                                ),));
                          }
                        else{
                            print(localNews);
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                NewsDetailScreen( localNews : localNews,
                                ),));
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 14,
                              color: col.primary,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style:  TextStyle(
                              fontSize: 12,
                              color: col.onSurfaceVariant,
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
      ),
    );
  }
}

import 'package:taazakhabar/modules/news/domain/models/news_model.dart';
import 'package:taazakhabar/modules/news/infrastructure/services/news_service.dart';


class NewsRepository {
  final NewsService apiService;

  NewsRepository(this.apiService);

  Future<List<NewsModel>> fetchNews() async {
    List<NewsModel> newsList = [];
    try {
      final response = await apiService.getAllNews();
      if (response.isSuccessful) {
        print("successful");
        final Map<String, dynamic>? responseData = response.body;
        if (responseData != null && responseData.containsKey('articles')) {
          final List<dynamic> articles = responseData['articles'];
          for (var article in articles) {
            if (article is Map<String, dynamic>) {
              // Convert the JSON map to NewsModel
              NewsModel news = NewsModel.fromJson(article);
              newsList.add(news);
            } else {
              throw Exception('Invalid article format');
            }
          }
          return newsList;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to fetch news: ${response.error}');
      }
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }

  Future<List<NewsModel>> fetchFavNews(String category) async {
    List<NewsModel> newsList = [];
    try {
      final response = await apiService.getFavouriteNews(category: category);
      if (response.isSuccessful) {
        print("successful");
        final Map<String, dynamic>? responseData = response.body;
        if (responseData != null && responseData.containsKey('articles')) {
          final List<dynamic> articles = responseData['articles'];
          for (var article in articles) {
            if (article is Map<String, dynamic>) {
              // Convert the JSON map to NewsModel
              NewsModel news = NewsModel.fromJson(article);
              newsList.add(news);
            } else {
              throw Exception('Invalid article format');
            }
          }
          return newsList;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to fetch news: ${response.error}');
      }
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }
}

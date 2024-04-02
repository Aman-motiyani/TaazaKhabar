import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:taazakhabar/modules/news/infrastructure/services/news_service.dart';
import 'package:taazakhabar/modules/news/infrastructure/repos/news_repository.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  group('NewsRepository', () {
    late NewsRepository newsRepository;
    late MockNewsService mockNewsService;

    setUp(() {
      mockNewsService = MockNewsService();
      newsRepository = NewsRepository(mockNewsService);
    });

    test('fetchNews should return a list of NewsModel', () async {
      final mockResponse = {
        'articles': [
          {
            'author': 'Author 1',
            'title': 'Title 1',
            'description': 'Description 1',
            'url': 'URL 1',
            'urlToImage': 'Image URL 1',
            'publishedAt': 'Published At 1',
            'content': 'Content 1',
          },
          {
            'author': 'Author 2',
            'title': 'Title 2',
            'description': 'Description 2',
            'url': 'URL 2',
            'urlToImage': 'Image URL 2',
            'publishedAt': 'Published At 2',
            'content': 'Content 2',
          }
        ]
      };

      when(() => mockNewsService.getAllNews()).thenAnswer((_) async => Response<Map<String, dynamic>>(http.Response(jsonEncode(mockResponse), 200), mockResponse));

      final result = await newsRepository.fetchNews();

      expect(result.length, 2);
      expect(result.first.author, 'Author 1');
      expect(result.last.title, 'Title 2');
    });

    test('fetchFavNews should return a list of NewsModel', () async {
      final mockResponse = {
        'articles': [
          {
            'author': 'Fav Author 1',
            'title': 'Fav Title 1',
            'description': 'Fav Description 1',
            'url': 'Fav URL 1',
            'urlToImage': 'Fav Image URL 1',
            'publishedAt': 'Fav Published At 1',
            'content': 'Fav Content 1',
          },
          {
            'author': 'Fav Author 2',
            'title': 'Fav Title 2',
            'description': 'Fav Description 2',
            'url': 'Fav URL 2',
            'urlToImage': 'Fav Image URL 2',
            'publishedAt': 'Fav Published At 2',
            'content': 'Fav Content 2',
          }
        ]
      };

      when(() => mockNewsService.getFavouriteNews(category: any(named: 'category'))).thenAnswer((_) async => Response<Map<String, dynamic>>(http.Response(jsonEncode(mockResponse), 200), mockResponse));

      final result = await newsRepository.fetchFavNews('category');

      expect(result.length, 2);
      expect(result.first.author, 'Fav Author 1');
      expect(result.last.title, 'Fav Title 2');
    });
  });
}

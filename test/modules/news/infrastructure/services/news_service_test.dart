import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:taazakhabar/modules/news/infrastructure/services/news_service.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  group('NewsService', () {
    late MockNewsService newsService;

    setUp(() {
      newsService = MockNewsService();
    });

    test('getAllNews returns a response', () async {
      final mockResponse = Response<Map<String, dynamic>>(http.Response('{"key": "value"}', 200), const {'key': 'value'});


      when(() => newsService.getAllNews()).thenAnswer((_) async => mockResponse);

      final response = await newsService.getAllNews();

      expect(response, isNotNull);
      expect(response.statusCode, 200);
      expect(response.body?['key'], 'value');

      verify(() => newsService.getAllNews()).called(1);
    });

    test('getFavouriteNews returns a response', () async {
      final mockResponse = Response<Map<String, dynamic>>(http.Response('{"key": "value"}', 200), const {'key': 'value'});

      when(() => newsService.getFavouriteNews(category: any(named: 'category'))).thenAnswer((_) async => mockResponse);

      final response = await newsService.getFavouriteNews(category: 'sports');

      expect(response, isNotNull);
      expect(response.statusCode, 200);
      expect(response.body?['key'], 'value');

      verify(() => newsService.getFavouriteNews(category: 'sports')).called(1);
    });
  });
}

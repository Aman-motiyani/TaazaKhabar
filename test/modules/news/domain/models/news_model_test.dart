import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/modules/news/domain/models/news_model.dart';


void main() {
  group('NewsModel', () {
    test('fromJson() should properly deserialize JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        "author": "John Doe",
        "title": "Sample Title",
        "description": "Sample Description",
        "url": "https://example.com",
        "urlToImage": "https://example.com/image.jpg",
        "publishedAt": "2024-04-01",
        "content": "Sample content"
      };

      // Act
      final newsModel = NewsModel.fromJson(json);

      // Assert
      expect(newsModel.author, 'John Doe');
      expect(newsModel.title, 'Sample Title');
      expect(newsModel.description, 'Sample Description');
      expect(newsModel.url, 'https://example.com');
      expect(newsModel.urlToImage, 'https://example.com/image.jpg');
      expect(newsModel.publishedAt, '2024-04-01');
      expect(newsModel.content, 'Sample content');
    });

    test('toJson() should properly serialize to JSON', () {
      // Arrange
      final newsModel = NewsModel(
        author: 'John Doe',
        title: 'Sample Title',
        description: 'Sample Description',
        url: 'https://example.com',
        urlToImage: 'https://example.com/image.jpg',
        publishedAt: '2024-04-01',
        content: 'Sample content',
      );

      // Act
      final json = newsModel.toJson();

      // Assert
      expect(json['author'], 'John Doe');
      expect(json['title'], 'Sample Title');
      expect(json['description'], 'Sample Description');
      expect(json['url'], 'https://example.com');
      expect(json['urlToImage'], 'https://example.com/image.jpg');
      expect(json['publishedAt'], '2024-04-01');
      expect(json['content'], 'Sample content');
    });
  });
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$NewsService extends NewsService {
  _$NewsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = NewsService;

  @override
  Future<Response<dynamic>> getAllNews({
    String? country = NewsService.country,
    String? apiKey = NewsService.apiKey,
  }) {
    final Uri $url = Uri.parse('https://newsapi.org/v2/top-headlines');
    final Map<String, dynamic> $params = <String, dynamic>{
      'country': country,
      'apiKey': apiKey,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFavouriteNews({
    String? country = NewsService.country,
    String? category,
    String? apiKey = NewsService.apiKey,
  }) {
    final Uri $url = Uri.parse('https://newsapi.org/v2/top-headlines');
    final Map<String, dynamic> $params = <String, dynamic>{
      'country': country,
      'category': category,
      'apiKey': apiKey,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}

import 'package:chopper/chopper.dart';
import 'package:taazakhabar/core/services/interceptors/api_interceptor.dart';
part 'news_service.chopper.dart';

@ChopperApi(baseUrl: 'https://newsapi.org/v2')
abstract class NewsService extends ChopperService {
  static const String apiKey = 'b3c093eb64a040708058d0733a4a511a'; // Static API key
  static const String country = 'in'; // Static country code

  @Get(path: '/top-headlines')
  Future<Response> getAllNews({
    @Query('country') String? country = NewsService.country,
    @Query('apiKey') String? apiKey = NewsService.apiKey,
  });

  @Get(path: '/top-headlines')
  Future<Response> getFavouriteNews({
    @Query('country') String? country = NewsService.country,
    @Query('category') String? category,
    @Query('apiKey') String? apiKey = NewsService.apiKey,
  });

  static NewsService create() {
    final client = ChopperClient(
      baseUrl: Uri.tryParse('https://newsapi.org/v2'),
      services: [
        _$NewsService(),
      ],
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
      interceptors: [ErrorHandlingInterceptor()]
    );
    return _$NewsService(client);
  }
}

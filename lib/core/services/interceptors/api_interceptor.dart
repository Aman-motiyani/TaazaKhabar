import 'package:chopper/chopper.dart';

class ApiKeyInterceptor implements RequestInterceptor {
  final String apiKey;

  ApiKeyInterceptor(this.apiKey);

  @override
  Future<Request> onRequest(Request request) async {
    final Map<String, String> headers = request.headers.map as Map<String, String>;
    headers['Authorization'] = 'Bearer $apiKey';
    return request.copyWith(headers: headers);
  }
}

class ErrorHandlingInterceptor implements ResponseInterceptor {
  @override
  Future<Response> onResponse(Response response) async {
    if (response.isSuccessful) {
      return response;
    } else {
      switch (response.statusCode) {
        case 400:
          throw Exception(response.body.toString());
        case 401:
          throw Exception(response.body.toString());
        case 403:
          throw Exception(response.body.toString());
        case 404:
          throw Exception(response.body.toString());
        case 500:
          throw Exception(response.body.toString());
        default:
          throw Exception(response.body.toString());
      }
    }
  }

  @override
  Future<Response> onError(Response response) async {
    throw Exception('Failed to fetch news: ${response.statusCode}');
  }
}
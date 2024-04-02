import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:taazakhabar/modules/weather/infrastructure/services/weather_service.dart';

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  group('WeatherService', () {
    late MockWeatherService weatherService;

    setUp(() {
      weatherService = MockWeatherService();
    });

    test('getWeather returns a response', () async {
      final mockResponse = Response<Map<String, dynamic>>(http.Response('{"key": "value"}', 200), {"key": "value"});

      when(() => weatherService.getWeather(city: any(named: 'city'))).thenAnswer((_) async => mockResponse);

      final response = await weatherService.getWeather(city: 'London');

      expect(response, isNotNull);
      expect(response.statusCode, 200);
      expect(response.body?['key'], 'value');

      verify(() => weatherService.getWeather(city: 'London')).called(1);
    });

    test('getWeather handles errors', () async {
      final errorResponse = Response<Map<String, dynamic>>(
        http.Response('Error message', 404), // Correct the error message here
        {'message': 'Error message'}, // Adjust the expected error message here
      );

      when(() => weatherService.getWeather(city: any(named: 'city')))
          .thenAnswer((_) async => errorResponse);

      final response = await weatherService.getWeather(city: 'London');

      expect(response, isNotNull);
      expect(response.statusCode, 404);
      expect(response.body['message'], 'Error message'); // Correct the expected error message here

      verify(() => weatherService.getWeather(city: 'London')).called(1);
    });
  });
}

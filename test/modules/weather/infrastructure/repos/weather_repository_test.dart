import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taazakhabar/modules/weather/infrastructure/services/weather_service.dart';
import 'package:taazakhabar/modules/weather/infrastructure/repos/weather_repository.dart';

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  group('WeatherRepository', () {
    late WeatherRepository weatherRepository;
    late MockWeatherService mockWeatherService;

    setUp(() {
      mockWeatherService = MockWeatherService();
      weatherRepository = WeatherRepository(mockWeatherService);
    });

    test('fetchWeather should return a WeatherModel', () async {
      final mockResponse = {
        "weather": [
          {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}
        ],
        "main": {"temp": 27.33, "feels_like": 28.6, "temp_min": 27, "temp_max": 28, "pressure": 1010, "humidity": 74},
        "name": "London"
      };

      when(() => mockWeatherService.getWeather(city: any(named: 'city'))).thenAnswer((_) async => Response<Map<String, dynamic>>(http.Response(jsonEncode(mockResponse), 200), mockResponse));

      final result = await weatherRepository.fetchWeather('London');

      expect(result.name, 'London');
      expect(result.weather.first.main, 'Clear');
      expect(result.main.temp, 27.33);
    });
  });
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WeatherService extends WeatherService {
  _$WeatherService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WeatherService;

  @override
  Future<Response<dynamic>> getWeather({
    String? city,
    String? units = 'metric',
    String? apiKey = WeatherService.apiKey,
  }) {
    final Uri $url =
        Uri.parse('https://api.openweathermap.org/data/2.5/weather');
    final Map<String, dynamic> $params = <String, dynamic>{
      'q': city,
      'units': units,
      'appid': apiKey,
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

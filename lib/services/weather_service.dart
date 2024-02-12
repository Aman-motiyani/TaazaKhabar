import 'package:chopper/chopper.dart';
part 'weather_service.chopper.dart';

@ChopperApi(baseUrl: 'https://api.openweathermap.org/data/2.5')
abstract class WeatherService extends ChopperService {
  static const String apiKey = '5d7b702e382e8bcdd650db6eebf78fc1'; // Your OpenWeatherMap API key

  @Get(path: '/weather')
  Future<Response> getWeather({
    @Query('q') String? city,
    @Query('units') String? units = 'metric',
    @Query('appid') String? apiKey = WeatherService.apiKey,
  });

  static WeatherService create() {
    final client = ChopperClient(
      baseUrl: Uri.tryParse('https://api.openweathermap.org/data/2.5'),
      services: [
        _$WeatherService(),
      ],
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
    );
    return _$WeatherService(client);
  }
}

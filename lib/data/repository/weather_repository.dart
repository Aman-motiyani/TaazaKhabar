import 'package:taazakhabar/data/models/weather_model.dart';
import 'package:taazakhabar/services/weather_service.dart';

class WeatherRepository {
  final WeatherService weatherService;

  WeatherRepository(this.weatherService);

  Future<WeatherModel> fetchWeather(String city) async {
    try {
      final response = await weatherService.getWeather(city: city);
      print(response.body);
      if (response.isSuccessful) {
        final Map<String, dynamic>? responseData = response.body;
        if (responseData != null) {
          // Check if both 'weather' and 'main' keys exist in the response data
          if (responseData.containsKey('weather') && responseData.containsKey('main')) {
            // Parse the response data into a WeatherModel object
            final weatherModel = WeatherModel.fromJson(responseData);
            return weatherModel;
          } else {
            throw Exception('Weather data is incomplete.');
          }
        } else {
          throw Exception('Response data is null.');
        }
      } else {
        throw Exception('Failed to fetch weather: ${response.error}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }

}

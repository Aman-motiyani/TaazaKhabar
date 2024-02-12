part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {}

class FetchWeather extends WeatherEvent {
  final String city;

  FetchWeather(this.city);

  @override
  List<Object> get props => [city];
}

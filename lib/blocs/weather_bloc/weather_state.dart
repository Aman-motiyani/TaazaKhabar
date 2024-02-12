part of 'weather_bloc.dart';

@immutable
abstract class WeatherState  extends Equatable{
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;

  WeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);

  @override
  List<Object> get props => [message];
}

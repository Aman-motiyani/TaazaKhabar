import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:taazakhabar/data/models/weather_model.dart';
import 'package:taazakhabar/data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    // Emit NewsLoading state
    emit(WeatherLoading());
    try {
      final WeatherModel weather = await weatherRepository.fetchWeather(event.city);
      // Emit NewsLoaded state with newsList
      emit(WeatherLoaded(weather));
    } catch (e) {
      // Emit NewsError state with error message
      emit(WeatherError('Failed to fetch news: $e'));
    }
  }
}



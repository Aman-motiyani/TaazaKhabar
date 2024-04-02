import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taazakhabar/modules/weather/domain/models/weather_model.dart';
import 'package:taazakhabar/modules/weather/infrastructure/repos/weather_repository.dart';
import 'package:taazakhabar/modules/weather/presentation/logic/weather_bloc/weather_bloc.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('WeatherBloc', () {
    late WeatherRepository weatherRepository;
    late WeatherBloc weatherBloc;

    setUp(() {
      weatherRepository = MockWeatherRepository();
      weatherBloc = WeatherBloc(weatherRepository);
    });

    tearDown(() {
      weatherBloc.close();
    });

    test('initial state is WeatherInitial', () {
      expect(weatherBloc.state, WeatherInitial());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when FetchWeather is added',
      build: () {
        when(() => weatherRepository.fetchWeather(any())).thenAnswer((_) async => WeatherModel(
          weather: [],
          main: Main(temp: 0, feelsLike: 0, tempMin: 0, tempMax: 0, pressure: 0, humidity: 0),
          name: 'London',
        ));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeather('London')),
      expect: () => [
        WeatherLoading(),
        isA<WeatherLoaded>(),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when FetchWeather fails',
      build: () {
        when(() => weatherRepository.fetchWeather(any())).thenThrow(Exception());
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeather('London')),
      expect: () => [
        WeatherLoading(),
        isA<WeatherError>(),
      ],
    );
  });
}

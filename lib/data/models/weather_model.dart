// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  List<Weather> weather;
  Main main;
  String name;

  WeatherModel({
    required this.weather,
    required this.main,
    required this.name,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    main: Main.fromJson(json["main"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "main": main.toJson(),
    "name": name,
  };
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"]?.toDouble(),
    feelsLike: json["feels_like"]?.toDouble(),
    tempMin: json["temp_min"]?.toDouble(),
    tempMax: json["temp_max"]?.toDouble(),
    pressure: json["pressure"],
    humidity: json["humidity"],
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "humidity": humidity,
  };
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/core/repository/models/weather.dart' hide Weather;
import 'package:weather_app/core/repository/models/weather.dart'
    as weather_repository;

part 'weather.g.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

@JsonSerializable()
class Temperature extends Equatable {
  const Temperature({required this.value});

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  final double value;

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);

  @override
  List<Object> get props => [value];
}

@JsonSerializable()
class Weather extends Equatable {
  const Weather(
      {required this.condition,
      required this.lastUpdated,
      required this.location,
      required this.temperature,
      required this.weatherStateAbr,
      required this.minTemp,
      required this.maxTemp,
      required this.windSpeed,
      required this.windDirection,
      required this.humidity,
      required this.airPressure,
      required this.date});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  // factory Weather.fromRepository(weather_repository.Weather weather) {
  //   return Weather(
  //     condition: weather.condition,
  //     lastUpdated: DateTime.now(),
  //     location: weather.location,
  //     temperature: Temperature(value: weather.temperature),
  //   );
  // }

  static final empty = Weather(
      condition: 'unknown',
      lastUpdated: DateTime(0),
      temperature: const Temperature(value: 0),
      location: '--',
      airPressure: 0,
      humidity: 0,
      maxTemp: const Temperature(value: 0),
      minTemp: const Temperature(value: 0),
      weatherStateAbr: '',
      windDirection: 0,
      windSpeed: 0,
      date: DateTime.now());

  final String condition;
  final DateTime lastUpdated;
  final String location;
  final Temperature temperature;
  final String weatherStateAbr;
  final Temperature minTemp;
  final Temperature maxTemp;
  final double windSpeed;
  final double windDirection;
  final int humidity;
  final double airPressure;
  final DateTime date;

  @override
  List<Object> get props => [condition, lastUpdated, location, temperature];

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  Weather copyWith(
      {String? condition,
      DateTime? lastUpdated,
      String? location,
      Temperature? temperature,
      String? weatherStateAbr,
      Temperature? minTemp,
      Temperature? maxTemp,
      double? windSpeed,
      double? windDirection,
      int? humidity,
      double? airPressure,
      DateTime? date}) {
    return Weather(
        condition: condition ?? this.condition,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        location: location ?? this.location,
        temperature: temperature ?? this.temperature,
        airPressure: airPressure ?? this.airPressure,
        humidity: humidity ?? this.humidity,
        maxTemp: maxTemp ?? this.maxTemp,
        minTemp: minTemp ?? this.minTemp,
        weatherStateAbr: weatherStateAbr ?? this.weatherStateAbr,
        windDirection: windDirection ?? this.windDirection,
        windSpeed: windSpeed ?? this.windSpeed,
        date: date ?? this.date);
  }
}

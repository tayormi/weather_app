import 'package:equatable/equatable.dart';
import 'package:weather_app/presentation/models/weather.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

class WeatherState extends Equatable {
  const WeatherState(
      {this.status = WeatherStatus.initial,
      this.temperatureUnits = TemperatureUnits.celsius,
      required this.weathers,
      required this.weatherDetails});

  factory WeatherState.initial() {
    return WeatherState(
        weathers: const [],
        weatherDetails: Weather(
            airPressure: 0,
            condition: 'unknown',
            date: DateTime.now(),
            humidity: 0,
            lastUpdated: DateTime.now(),
            location: '',
            maxTemp: const Temperature(value: 0),
            minTemp: const Temperature(value: 0),
            temperature: const Temperature(value: 0),
            windDirection: 0,
            weatherStateAbr: '',
            windSpeed: 0));
  }

  final WeatherStatus status;
  final List<Weather> weathers;
  final Weather weatherDetails;
  final TemperatureUnits temperatureUnits;

  WeatherState copyWith(
      {WeatherStatus? status,
      TemperatureUnits? temperatureUnits,
      List<Weather>? weathers,
      final Weather? weatherDetails}) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weathers: weathers ?? this.weathers,
      weatherDetails: weatherDetails ?? this.weatherDetails,
    );
  }

  @override
  List<Object?> get props =>
      [status, temperatureUnits, weathers, weatherDetails];
}

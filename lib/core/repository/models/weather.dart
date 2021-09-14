import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

@JsonSerializable()
class Weather extends Equatable {
  const Weather(
      {required this.location,
      required this.temperature,
      required this.condition,
      required this.weatherStateAbr,
      required this.minTemp,
      required this.maxTemp,
      required this.windSpeed,
      required this.windDirection,
      required this.humidity,
      required this.airPressure,
      required this.applicableDate});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  final String location;
  final double temperature;
  final String condition;
  final String weatherStateAbr;
  final double minTemp;
  final double maxTemp;
  final double windSpeed;
  final double windDirection;
  final int humidity;
  final double airPressure;
  final DateTime applicableDate;

  @override
  List<Object> get props => [
        location,
        temperature,
        condition,
        weatherStateAbr,
        minTemp,
        maxTemp,
        windSpeed,
        windDirection,
        humidity,
        airPressure,
        applicableDate
      ];
}

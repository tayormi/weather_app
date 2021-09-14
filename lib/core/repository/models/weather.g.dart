// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return $checkedNew('Weather', json, () {
    final val = Weather(
      location: $checkedConvert(json, 'location', (v) => v as String),
      temperature:
          $checkedConvert(json, 'temperature', (v) => (v as num).toDouble()),
      condition: $checkedConvert(json, 'condition', (v) => v as String),
      weatherStateAbr:
          $checkedConvert(json, 'weather_state_abr', (v) => v as String),
      minTemp: $checkedConvert(json, 'min_temp', (v) => (v as num).toDouble()),
      maxTemp: $checkedConvert(json, 'max_temp', (v) => (v as num).toDouble()),
      windSpeed:
          $checkedConvert(json, 'wind_speed', (v) => (v as num).toDouble()),
      windDirection:
          $checkedConvert(json, 'wind_direction', (v) => (v as num).toDouble()),
      humidity: $checkedConvert(json, 'humidity', (v) => v as int),
      airPressure:
          $checkedConvert(json, 'air_pressure', (v) => (v as num).toDouble()),
      applicableDate: $checkedConvert(
          json, 'applicable_date', (v) => DateTime.parse(v as String)),
    );
    return val;
  }, fieldKeyMap: const {
    'weatherStateAbr': 'weather_state_abr',
    'minTemp': 'min_temp',
    'maxTemp': 'max_temp',
    'windSpeed': 'wind_speed',
    'windDirection': 'wind_direction',
    'airPressure': 'air_pressure',
    'applicableDate': 'applicable_date'
  });
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'location': instance.location,
      'temperature': instance.temperature,
      'condition': instance.condition,
      'weather_state_abr': instance.weatherStateAbr,
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'wind_speed': instance.windSpeed,
      'wind_direction': instance.windDirection,
      'humidity': instance.humidity,
      'air_pressure': instance.airPressure,
      'applicable_date': instance.applicableDate.toIso8601String(),
    };

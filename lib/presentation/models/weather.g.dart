// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Temperature _$TemperatureFromJson(Map<String, dynamic> json) {
  return $checkedNew('Temperature', json, () {
    final val = Temperature(
      value: $checkedConvert(json, 'value', (v) => (v as num).toDouble()),
    );
    return val;
  });
}

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return $checkedNew('Weather', json, () {
    final val = Weather(
      condition: $checkedConvert(json, 'condition', (v) => v as String),
      lastUpdated: $checkedConvert(
          json, 'last_updated', (v) => DateTime.parse(v as String)),
      location: $checkedConvert(json, 'location', (v) => v as String),
      temperature: $checkedConvert(json, 'temperature',
          (v) => Temperature.fromJson(v as Map<String, dynamic>)),
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
      date: $checkedConvert(json, 'date', (v) => DateTime.parse(v as String)),
    );
    return val;
  }, fieldKeyMap: const {
    'lastUpdated': 'last_updated',
    'weatherStateAbr': 'weather_state_abr',
    'minTemp': 'min_temp',
    'maxTemp': 'max_temp',
    'windSpeed': 'wind_speed',
    'windDirection': 'wind_direction',
    'airPressure': 'air_pressure'
  });
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'condition': instance.condition,
      'last_updated': instance.lastUpdated.toIso8601String(),
      'location': instance.location,
      'temperature': instance.temperature.toJson(),
      'weather_state_abr': instance.weatherStateAbr,
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'wind_speed': instance.windSpeed,
      'wind_direction': instance.windDirection,
      'humidity': instance.humidity,
      'air_pressure': instance.airPressure,
      'date': instance.date.toIso8601String(),
    };

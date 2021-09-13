// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    id: json['id'] as int,
    weatherStateName: json['weatherStateName'] as String,
    weatherStateAbbr: _$enumDecode(
        _$WeatherStateEnumMap, json['weatherStateAbbr'],
        unknownValue: WeatherState.unknown),
    windDirectionCompass: _$enumDecode(
        _$WindDirectionCompassEnumMap, json['windDirectionCompass'],
        unknownValue: WindDirectionCompass.unknown),
    created: DateTime.parse(json['created'] as String),
    applicableDate: DateTime.parse(json['applicableDate'] as String),
    minTemp: (json['minTemp'] as num).toDouble(),
    maxTemp: (json['maxTemp'] as num).toDouble(),
    theTemp: (json['theTemp'] as num).toDouble(),
    windSpeed: (json['windSpeed'] as num).toDouble(),
    windDirection: (json['windDirection'] as num).toDouble(),
    airPressure: (json['airPressure'] as num).toDouble(),
    humidity: json['humidity'] as int,
    visibility: (json['visibility'] as num).toDouble(),
    predictability: json['predictability'] as int,
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'weatherStateName': instance.weatherStateName,
      'weatherStateAbbr': _$WeatherStateEnumMap[instance.weatherStateAbbr],
      'windDirectionCompass':
          _$WindDirectionCompassEnumMap[instance.windDirectionCompass],
      'created': instance.created.toIso8601String(),
      'applicableDate': instance.applicableDate.toIso8601String(),
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'theTemp': instance.theTemp,
      'windSpeed': instance.windSpeed,
      'windDirection': instance.windDirection,
      'airPressure': instance.airPressure,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
      'predictability': instance.predictability,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$WeatherStateEnumMap = {
  WeatherState.snow: 'sn',
  WeatherState.sleet: 'sl',
  WeatherState.hail: 'h',
  WeatherState.thunderstorm: 't',
  WeatherState.heavyRain: 'hr',
  WeatherState.lightRain: 'lr',
  WeatherState.showers: 's',
  WeatherState.heavyCloud: 'hc',
  WeatherState.lightCloud: 'lc',
  WeatherState.clear: 'c',
  WeatherState.unknown: 'unknown',
};

const _$WindDirectionCompassEnumMap = {
  WindDirectionCompass.north: 'N',
  WindDirectionCompass.northEast: 'NE',
  WindDirectionCompass.east: 'E',
  WindDirectionCompass.southEast: 'SE',
  WindDirectionCompass.south: 'S',
  WindDirectionCompass.southWest: 'SW',
  WindDirectionCompass.west: 'W',
  WindDirectionCompass.northWest: 'NW',
  WindDirectionCompass.unknown: 'unknown',
};

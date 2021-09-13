import 'package:weather_app/core/service/api_client.dart';
import 'package:weather_app/core/service/models/weather.dart' hide Weather;

import 'models/weather.dart';

class WeatherFailure implements Exception {}

class WeatherRepository {
  WeatherRepository({APIClient? apiClient})
      : _apiClient = apiClient ?? APIClient();

  final APIClient _apiClient;

  Future<Weather> getWeather(String city) async {
    final location = await _apiClient.locationSearch(city);
    final woeid = location.woeid;
    final weather = await _apiClient.getWeather(woeid);
    return Weather(
      temperature: weather.theTemp,
      location: location.title,
      condition: weather.weatherStateAbbr.toCondition,
    );
  }
}

extension on WeatherState {
  WeatherCondition get toCondition {
    switch (this) {
      case WeatherState.clear:
        return WeatherCondition.clear;
      case WeatherState.snow:
      case WeatherState.sleet:
      case WeatherState.hail:
        return WeatherCondition.snowy;
      case WeatherState.thunderstorm:
      case WeatherState.heavyRain:
      case WeatherState.lightRain:
      case WeatherState.showers:
        return WeatherCondition.rainy;
      case WeatherState.heavyCloud:
      case WeatherState.lightCloud:
        return WeatherCondition.cloudy;
      default:
        return WeatherCondition.unknown;
    }
  }
}

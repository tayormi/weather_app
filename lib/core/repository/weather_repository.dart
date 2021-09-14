import 'package:weather_app/core/service/api_client.dart';
import 'package:weather_app/core/service/models/weather.dart' hide Weather;

import 'models/weather.dart';

class WeatherFailure implements Exception {}

class WeatherRepository {
  WeatherRepository({APIClient? apiClient})
      : _apiClient = apiClient ?? APIClient();

  final APIClient _apiClient;

  Future<List<Weather>> getWeather(String city) async {
    final List<Weather> weather = [];
    final location = await _apiClient.locationSearch(city);
    final woeid = location.woeid;
    final weathers = await _apiClient.getWeather(woeid);
    for (var item in weathers) {
      weather.add(Weather(
          temperature: item.theTemp,
          location: location.title,
          condition: item.weatherStateName,
          airPressure: item.airPressure,
          humidity: item.humidity,
          maxTemp: item.maxTemp,
          minTemp: item.minTemp,
          weatherStateAbr: item.weatherStateAbbr.abbr!,
          windDirection: item.windDirection,
          windSpeed: item.windSpeed,
          applicableDate: item.applicableDate));
    }
    return weather;
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

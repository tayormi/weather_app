import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_app/core/service/models/weather.dart';

import 'models/location.dart';

/// Exception thrown when locationSearch fails.
class LocationIdRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

class APIClient {
  final Dio _dio;
  static const _baseUrl = 'www.metaweather.com';
  APIClient({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  /// Finds a [Location] `/api/location/search/?query=(query)`.
  Future<Location> locationSearch(String query) async {
    const url = '/api/location/search';
    final queryParamater = {'query': query};
    try {
      final response = await _dio.get(url, queryParameters: queryParamater);

      final locationJson = jsonDecode(
        response.data,
      ) as List;

      if (locationJson.isEmpty) {
        throw LocationNotFoundFailure();
      }

      return Location.fromJson(locationJson.first as Map<String, dynamic>);
    } catch (e) {
      throw LocationIdRequestFailure();
    }
  }

  /// Fetches [Weather] for a given [locationId].
  Future<Weather> getWeather(int locationId) async {
    final url = '/api/location/$locationId';
    try {
      final response = await _dio.get(url);

      final bodyJson = jsonDecode(response.data) as Map<String, dynamic>;

      if (bodyJson.isEmpty) {
        throw WeatherNotFoundFailure();
      }

      final weatherJson = bodyJson['consolidated_weather'] as List;

      if (weatherJson.isEmpty) {
        throw WeatherNotFoundFailure();
      }
      return Weather.fromJson(weatherJson.first as Map<String, dynamic>);
    } catch (e) {
      throw WeatherRequestFailure();
    }
  }
}

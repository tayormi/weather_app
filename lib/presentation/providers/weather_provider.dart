import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app/core/repository/weather_repository.dart'
    show WeatherRepository;
import 'package:weather_app/presentation/models/weather.dart';
import 'weather_state.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) => WeatherRepository(),
);

final weatherNotifierProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(ref.watch(weatherRepositoryProvider)),
);

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier(this._weatherRepository) : super(WeatherState.initial());

  final WeatherRepository _weatherRepository;

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;

    state = state.copyWith(status: WeatherStatus.loading);

    try {
      final weatherList = <Weather>[];
      final weather = await _weatherRepository.getWeather(city);

      final units = state.temperatureUnits;

      for (var item in weather) {
        final value = units.isFahrenheit
            ? item.temperature.toFahrenheit()
            : item.temperature;

        weatherList.add(Weather(
            condition: item.condition,
            location: item.location,
            temperature: Temperature(value: value),
            lastUpdated: DateTime.now(),
            airPressure: item.airPressure,
            humidity: item.humidity,
            maxTemp: Temperature(
                value: units.isFahrenheit
                    ? item.maxTemp.toFahrenheit()
                    : item.maxTemp),
            minTemp: Temperature(
                value: units.isFahrenheit
                    ? item.minTemp.toFahrenheit()
                    : item.minTemp),
            weatherStateAbr: item.weatherStateAbr,
            windDirection: item.windDirection,
            date: item.applicableDate,
            windSpeed: item.windSpeed));
      }

      state = state.copyWith(
          weatherDetails: weatherList.first,
          status: WeatherStatus.success,
          temperatureUnits: units,
          weathers: weatherList);
    } on Exception {
      state = state.copyWith(status: WeatherStatus.failure);
    }
  }

  void setWeatherDetails(Weather weather) {
    state = state.copyWith(weatherDetails: weather);
  }

  Future<void> refreshWeather() async {
    final weatherList = <Weather>[];
    if (!state.status.isSuccess) return;
    if (state.weathers.isEmpty) return;
    try {
      final weather =
          await _weatherRepository.getWeather(state.weathers[0].location);
      final units = state.temperatureUnits;

      for (var item in weather) {
        final value = units.isFahrenheit
            ? item.temperature.toFahrenheit()
            : item.temperature;
        weatherList.add(Weather(
            condition: item.condition,
            location: item.location,
            temperature: Temperature(value: value),
            lastUpdated: DateTime.now(),
            airPressure: item.airPressure,
            humidity: item.humidity,
            maxTemp: Temperature(
                value: units.isFahrenheit
                    ? item.maxTemp.toFahrenheit()
                    : item.maxTemp),
            minTemp: Temperature(
                value: units.isFahrenheit
                    ? item.minTemp.toFahrenheit()
                    : item.minTemp),
            weatherStateAbr: item.weatherStateAbr,
            windDirection: item.windDirection,
            date: item.applicableDate,
            windSpeed: item.windSpeed));
      }

      state = state.copyWith(
          weatherDetails: weatherList.first,
          status: WeatherStatus.success,
          temperatureUnits: units,
          weathers: weatherList);
    } on Exception {
      state = state;
    }
  }

  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    if (!state.status.isSuccess) {
      state = state.copyWith(temperatureUnits: units);
      return;
    }

    final weather = state.weathers;
    final weatherList = <Weather>[];
    if (weather.isNotEmpty) {
      for (var item in weather) {
        final temperature = item.temperature;
        final maxTemp = item.maxTemp;
        final minTemp = item.minTemp;
        final value = units.isCelsius
            ? temperature.value.toCelsius()
            : temperature.value.toFahrenheit();
        final maxTempValue = units.isCelsius
            ? maxTemp.value.toCelsius()
            : minTemp.value.toFahrenheit();
        final minTempValue = units.isCelsius
            ? maxTemp.value.toCelsius()
            : minTemp.value.toFahrenheit();

        weatherList.add(Weather(
            condition: item.condition,
            location: item.location,
            temperature: Temperature(value: value),
            lastUpdated: DateTime.now(),
            airPressure: item.airPressure,
            humidity: item.humidity,
            maxTemp: Temperature(value: maxTempValue),
            minTemp: Temperature(value: minTempValue),
            weatherStateAbr: item.weatherStateAbr,
            windDirection: item.windDirection,
            date: item.date,
            windSpeed: item.windSpeed));
      }

      state = state.copyWith(
          temperatureUnits: units,
          weathers: weatherList,
          weatherDetails: weatherList.first);
    }
  }
}

extension on double {
  double toFahrenheit() => ((this * 9 / 5) + 32);
  double toCelsius() => ((this - 32) * 5 / 9);
}

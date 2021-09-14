import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/models/weather.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';

class WeatherAvailable extends HookConsumerWidget {
  const WeatherAvailable(
      {Key? key,
      required this.onRefresh,
      required this.weather,
      required this.weatherDetails,
      required this.units})
      : super(key: key);

  final List<Weather> weather;
  final Weather weatherDetails;
  final ValueGetter<Future<void>> onRefresh;
  final TemperatureUnits units;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        _WeatherBackground(),
        RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat(DateFormat.WEEKDAY)
                          .format(weatherDetails.date)
                          .toUpperCase(),
                      style: theme.textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    weatherDetails.condition.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.network(
                      'https://www.metaweather.com/static/img/weather/${weatherDetails.weatherStateAbr}.svg',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      weatherDetails.formattedTemperature(units),
                      style: theme.textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 80,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Humidity: ${weatherDetails.humidity}%',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Pressure: ${weatherDetails.airPressure} hPa',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Wind: ${weatherDetails.windSpeed.toStringAsPrecision(2)} km/h',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return WeatherItem(
                          weather: weather[index],
                          onTap: () async {
                            ref
                                .read(weatherNotifierProvider.notifier)
                                .setWeatherDetails(weather[index]);
                          },
                          units: units,
                        );
                      },
                      itemCount: weather.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.25, 0.75, 0.90, 1.0],
          colors: [
            color,
            color.brighten(10),
            color.brighten(33),
            color.brighten(50),
          ],
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}

extension on Weather {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}

extension on Temperature {
  String formattedTemperatureItem(TemperatureUnits units) {
    return '''${value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}

class WeatherItem extends StatelessWidget {
  const WeatherItem(
      {Key? key,
      required this.weather,
      required this.onTap,
      required this.units})
      : super(key: key);

  final Weather weather;
  final ValueGetter<Future<void>> onTap;
  final TemperatureUnits units;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: 100,
        width: 120,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5)),

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                DateFormat(DateFormat.ABBR_WEEKDAY)
                    .format(weather.date)
                    .toUpperCase(),
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.network(
                  'https://www.metaweather.com/static/img/weather/${weather.weatherStateAbr}.svg',
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${weather.minTemp.formattedTemperatureItem(units)}/${weather.maxTemp.formattedTemperatureItem(units)}',
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

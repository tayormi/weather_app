import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app/presentation/city_search.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';
import 'package:weather_app/presentation/providers/weather_state.dart';
import 'package:weather_app/presentation/ui/setting_screen.dart';
import 'package:weather_app/presentation/ui/widgets/weather_available.dart';

import 'widgets/weather_empty.dart';
import 'widgets/weather_error.dart';
import 'widgets/weather_loading.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Weather'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const SettingsScreen())),
                  child: const Icon(Icons.settings)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                  onTap: () async {
                    final city = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const CitySearchScreen()));
                    ref
                        .read(weatherNotifierProvider.notifier)
                        .fetchWeather(city);
                  },
                  child: const Icon(Icons.search)),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () async {
            final city = await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CitySearchScreen()));
            ref.read(weatherNotifierProvider.notifier).fetchWeather(city);
          },
        ),
        body: Center(
          child:
              Consumer(builder: (BuildContext context, watch, Widget? child) {
            final state = ref.watch(weatherNotifierProvider);
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherEmpty();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                return WeatherAvailable(
                  onRefresh: () {
                    return ref
                        .read(weatherNotifierProvider.notifier)
                        .refreshWeather();
                  },
                  weather: state.weathers,
                  units: state.temperatureUnits,
                  weatherDetails: state.weatherDetails,
                );
              case WeatherStatus.failure:
              default:
                return const WeatherError();
            }
          }),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';
import 'package:weather_app/presentation/models/weather.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListTile(
        title: const Text('Temperature Units'),
        trailing: Switch(
          value: state.temperatureUnits.isCelsius,
          onChanged: (_) =>
              ref.read(weatherNotifierProvider.notifier).toggleUnits(),
        ),
      ),
    );
  }
}

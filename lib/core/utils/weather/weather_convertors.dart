import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:units_converter/units_converter.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_bloc.dart';

class WeatherConvertors {
  String formatTemperature(double temp, BuildContext context) {
    final bool isCelsius =
        context.read<SettingsBloc>().state.unit == unitsFormat.metric;
    if (isCelsius) {
      return '${temp.round()}°C';
    }
    final fahrenheit = temp.convertFromTo(
      TEMPERATURE.celsius,
      TEMPERATURE.fahrenheit,
    );
    return '${fahrenheit?.toStringAsFixed(1)}°F';
  }

  String formatDistance(double distance, BuildContext context) {
    final bool isCelsius =
        context.read<SettingsBloc>().state.unit == unitsFormat.metric;
    if (isCelsius) {
      return '${(distance.round() / 1000)} km';
    }
    final miles = distance.convertFromTo(
      LENGTH.kilometers,
      LENGTH.miles,
    );
    return '${(miles! / 1000).toStringAsFixed(1)} mi';
  }
}

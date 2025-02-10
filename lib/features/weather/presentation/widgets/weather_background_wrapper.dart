import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/weather/weather_utils.dart';

class WeatherBackgroundWrapper extends StatelessWidget {
  final String weatherCode;
  final Widget child;

  const WeatherBackgroundWrapper({
    super.key,
    required this.weatherCode,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: WeatherUtils.getBackgroundGradient(weatherCode),
      ),
      child: child,
    );
  }
}

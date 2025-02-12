import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/extensions/context_extensions.dart';
import 'package:weather_app/core/utils/weather/weather_convertors.dart';
import 'package:weather_app/core/utils/weather/weather_utils.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_weather_entity.dart';

class HourlyWeatherCard extends StatelessWidget {
  final HourlyWeatherEntity weather;
  final bool isNow;

  const HourlyWeatherCard({
    super.key,
    required this.weather,
    this.isNow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isNow
            ? Colors.white.withOpacity(0.3)
            : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isNow
                ? 'Now'
                : TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(
                        weather.timestamp * 1000))
                    .format(context),
            style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
          Image.network(
            WeatherUtils.getWeatherIcon(weather.iconCode),
            width: 40,
            height: 40,
          ),
          Text(
            WeatherConvertors().formatTemperature(weather.temperature, context),
            style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/utils/extensions/context_extensions.dart';
import 'package:weather_app/core/utils/weather/weather_utils.dart';
import '../../domain/entities/daily_weather_entity.dart';

class DailyWeatherCard extends StatelessWidget {
  final DailyWeatherEntity weather;
  final bool isToday;

  const DailyWeatherCard({
    super.key,
    required this.weather,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isToday ? 0.4 : 0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // date
          Text(
            DateFormat('dd MMM').format(
              DateTime.fromMillisecondsSinceEpoch(
                weather.timestamp * 1000,
              ),
            ),
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          // Day
          Expanded(
            flex: 2,
            child: Text(
              isToday
                  ? 'Today'
                  : DateFormat('EEEE').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        weather.timestamp * 1000,
                      ),
                    ),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          // Weather Icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Image.network(
              WeatherUtils.getWeatherIcon(weather.iconCode),
              width: 40,
              height: 40,
            ),
          ),
          // Rain Probability

          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Opacity(
                  opacity: weather.rainProbability,
                  child: Icon(
                    Icons.water_drop,
                    color: Colors.blue[600],
                    size: 16,
                  ),
                ),
                Text(
                  '${(weather.rainProbability * 100).round()}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.blue[600],
                      ),
                ),
              ],
            ),
          ),

          // Temperature
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${weather.temperature['min']?.round()}°',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(width: 8),
              Text(
                '${weather.temperature['max']?.round()}°',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/weather/weather_utils.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import '../../domain/entities/daily_weather_entity.dart';
import '../widgets/daily_weather_card.dart';

class DailyForecastPage extends StatelessWidget {
  final List<DailyWeatherEntity> dailyWeather;
  final String cityName;

  const DailyForecastPage({
    super.key,
    required this.dailyWeather,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    final gradient =
        WeatherUtils.getBackgroundGradient(dailyWeather.first.iconCode);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradient.colors,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                cityName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: dailyWeather.length,
                itemBuilder: (context, index) {
                  return DailyWeatherCard(
                    weather: dailyWeather[index],
                    isToday: index == 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

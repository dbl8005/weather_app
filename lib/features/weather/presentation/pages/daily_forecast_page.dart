import 'package:flutter/material.dart';
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1F1B2E),
            const Color(0xFF16151F),
          ],
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

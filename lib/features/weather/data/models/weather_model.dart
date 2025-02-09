import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required double temperature,
    required double feelsLike,
    required int humidity,
    required String description,
    required String iconCode,
    required double windSpeed,
    required String cityName,
  }) : super(
          temperature: temperature,
          feelsLike: feelsLike,
          humidity: humidity,
          description: description,
          iconCode: iconCode,
          windSpeed: windSpeed,
          cityName: cityName,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final weather = current['weather'][0];

    return WeatherModel(
      temperature: current['temp'].toDouble(),
      feelsLike: current['feels_like'].toDouble(),
      humidity: current['humidity'],
      description: weather['description'],
      iconCode: weather['icon'],
      windSpeed: current['wind_speed'].toDouble(),
      cityName: json['timezone'].split('/').last,
    );
  }
}

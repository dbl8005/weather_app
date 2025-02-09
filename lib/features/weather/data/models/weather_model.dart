import 'package:weather_app/features/weather/domain/entities/hourly_weather_entity.dart';
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
    required int pressure,
    required double uvi,
    required int clouds,
    required int visibility,
    required double dewPoint,
    required List<HourlyWeatherEntity> hourlyWeather,
  }) : super(
          temperature: temperature,
          feelsLike: feelsLike,
          humidity: humidity,
          description: description,
          iconCode: iconCode,
          windSpeed: windSpeed,
          cityName: cityName,
          pressure: pressure,
          uvi: uvi,
          clouds: clouds,
          visibility: visibility,
          dewPoint: dewPoint,
          hourlyWeather: hourlyWeather,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final weather = current['weather'][0];

    final List<HourlyWeatherEntity> hourly = (json['hourly'] as List)
        .take(24)
        .map(
          (hourly) => HourlyWeatherEntity(
            timestamp: hourly['dt'],
            temperature: (hourly['temp'] as num).toDouble(),
            iconCode: hourly['weather'][0]['icon'],
          ),
        )
        .toList();

    return WeatherModel(
      temperature: (current['temp'] as num).toDouble(),
      feelsLike: (current['feels_like'] as num).toDouble(),
      humidity: current['humidity'],
      description: weather['description'],
      iconCode: weather['icon'],
      windSpeed: (current['wind_speed'] as num).toDouble(),
      cityName: json['timezone'].split('/').last,
      pressure: current['pressure'],
      uvi: (current['uvi'] as num).toDouble(),
      clouds: current['clouds'],
      visibility: current['visibility'],
      dewPoint: (current['dew_point'] as num).toDouble(),
      hourlyWeather: hourly,
    );
  }
}

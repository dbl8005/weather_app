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
      pressure: current['pressure'],
      uvi: current['uvi'],
      clouds: current['clouds'],
      visibility: current['visibility'],
      dewPoint: current['dew_point'].toDouble(),
    );
  }
}

import 'package:weather_app/core/errors/weather_exception.dart';
import 'package:weather_app/core/utils/parse_utils.dart';
import 'package:weather_app/features/weather/domain/entities/daily_weather_entity.dart';
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
    required List<DailyWeatherEntity> dailyWeather,
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
          dailyWeather: dailyWeather,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    try {
      final current = json['current'] as Map<String, dynamic>?;
      if (current == null) {
        throw WeatherException(message: 'Current weather data is missing');
      }
      final weather =
          (current['weather'] as List?)?.firstOrNull as Map<String, dynamic>?;
      if (weather == null) {
        throw WeatherException(message: 'Weather data is missing');
      }

      String cityName = ParseUtils.asString(json['timezone']).split('/').last;
      cityName = cityName.replaceAll('_', ' ');

      final List<HourlyWeatherEntity> hourly = [];

      try {
        hourly.addAll(
          (json['hourly'] as List? ?? []).take(24).map(
                (hourly) => HourlyWeatherEntity(
                  timestamp: ParseUtils.toInt(hourly['dt']),
                  temperature: ParseUtils.toDouble(hourly['temp']),
                  iconCode: ParseUtils.asString(
                    hourly['weather'][0]['icon'],
                    defaultValue: '01d',
                  ),
                ),
              ),
        );
      } catch (e) {
        print('Error parsing hourly weather: $e');
      }

      final List<DailyWeatherEntity> daily = [];
      try {
        daily.addAll(((json['daily'] as List?) ?? [])
            .take(7)
            .map((daily) => DailyWeatherEntity(
                  timestamp: ParseUtils.toInt(daily['dt']),
                  sunrise: ParseUtils.toInt(daily['sunrise']),
                  sunset: ParseUtils.toInt(daily['sunset']),
                  moonrise: ParseUtils.toInt(daily['moonrise']),
                  moonset: ParseUtils.toInt(daily['moonset']),
                  moonPhase: ParseUtils.toDouble(daily['moon_phase']),
                  summary: ParseUtils.asString(daily['summary']),
                  temperature: ParseUtils.toDoubleMap(
                      daily['temp'] as Map<String, dynamic>?),
                  feelsLike: ParseUtils.toDoubleMap(
                      daily['feels_like'] as Map<String, dynamic>?),
                  pressure: ParseUtils.toInt(daily['pressure']),
                  humidity: ParseUtils.toInt(daily['humidity']),
                  windSpeed: ParseUtils.toDouble(daily['wind_speed']),
                  clouds: ParseUtils.toDouble(daily['clouds']),
                  dewPoint: ParseUtils.toDouble(daily['dew_point']),
                  uvi: ParseUtils.toDouble(daily['uvi']),
                  rainProbability: ParseUtils.toDouble(daily['pop']),
                  snowProbability: ParseUtils.toDouble(daily['snow']),
                  iconCode: ParseUtils.asString(
                    daily['weather']?[0]?['icon'],
                    defaultValue: '01d',
                  ),
                )));
      } catch (e) {
        print('Error parsing daily weather: $e');
      }

      return WeatherModel(
        temperature: ParseUtils.toDouble(current['temp']),
        feelsLike: ParseUtils.toDouble(current['feels_like']),
        humidity: ParseUtils.toInt(current['humidity']),
        description: ParseUtils.asString(weather['description']),
        iconCode: ParseUtils.asString(weather['icon'], defaultValue: '01d'),
        windSpeed: ParseUtils.toDouble(current['wind_speed']),
        cityName: cityName,
        pressure: ParseUtils.toInt(current['pressure']),
        uvi: ParseUtils.toDouble(current['uvi']),
        clouds: ParseUtils.toInt(current['clouds']),
        visibility: ParseUtils.toInt(current['visibility']),
        dewPoint: ParseUtils.toDouble(current['dew_point']),
        hourlyWeather: hourly,
        dailyWeather: daily,
      );
    } catch (e) {
      print('Error parsing weather: $e');
      throw WeatherException(message: 'Error parsing weather');
    }
  }
}

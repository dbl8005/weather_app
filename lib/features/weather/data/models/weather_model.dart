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

  factory WeatherModel.fromJson(Map<String, dynamic> json, {String? cityName}) {
    try {
      final current = json['current'];
      final weather = current['weather'][0];
      final hourly = (json['hourly'] as List)
          .take(24)
          .map((e) => HourlyWeatherEntity(
                timestamp: ParseUtils.toInt(e['dt']),
                temperature: ParseUtils.toDouble(e['temp']),
                iconCode: ParseUtils.asString(
                  e['weather'][0]['icon'],
                  defaultValue: '01d',
                ),
              ))
          .toList();
      final daily = (json['daily'] as List)
          .map((e) => DailyWeatherEntity(
                timestamp: ParseUtils.toInt(e['dt']),
                sunrise: ParseUtils.toInt(e['sunrise']),
                sunset: ParseUtils.toInt(e['sunset']),
                moonrise: ParseUtils.toInt(e['moonrise']),
                moonset: ParseUtils.toInt(e['moonset']),
                moonPhase: ParseUtils.toDouble(e['moon_phase']),
                summary: ParseUtils.asString(e['summary']),
                temperature:
                    ParseUtils.toDoubleMap(e['temp'] as Map<String, dynamic>?),
                feelsLike: ParseUtils.toDoubleMap(
                    e['feels_like'] as Map<String, dynamic>?),
                pressure: ParseUtils.toInt(e['pressure']),
                humidity: ParseUtils.toInt(e['humidity']),
                windSpeed: ParseUtils.toDouble(e['wind_speed']),
                clouds: ParseUtils.toDouble(e['clouds']),
                dewPoint: ParseUtils.toDouble(e['dew_point']),
                uvi: ParseUtils.toDouble(e['uvi']),
                rainProbability: ParseUtils.toDouble(e['pop']),
                snowProbability: ParseUtils.toDouble(e['snow']),
                iconCode: ParseUtils.asString(
                  e['weather'][0]?['icon'],
                  defaultValue: '01d',
                ),
              ))
          .toList();

      return WeatherModel(
        temperature: ParseUtils.toDouble(current['temp']),
        feelsLike: ParseUtils.toDouble(current['feels_like']),
        humidity: ParseUtils.toInt(current['humidity']),
        description: ParseUtils.asString(weather['description']),
        iconCode: ParseUtils.asString(weather['icon'], defaultValue: '01d'),
        windSpeed: ParseUtils.toDouble(current['wind_speed']),
        cityName: cityName ?? 'Unknown',
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

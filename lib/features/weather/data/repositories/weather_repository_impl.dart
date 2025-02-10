import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_app/core/constants/secrets.dart';
import 'package:weather_app/core/errors/weather_exception.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final String apiKey = Secrets.openWeatherApiKey;
  final String baseUrl = 'https://api.openweathermap.org/data/3.0';

  @override
  Future<WeatherEntity> getCurrentWeather() async {
    // Default coordinates (London)
    return getWeatherByLocation(51.5074, -0.1278);
  }

  @override
  Future<WeatherEntity> getWeatherByLocation(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely,alerts',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw WeatherException(
          message: 'Failed to load weather data',
          code: 'HTTP_${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is WeatherException) rethrow;
      throw WeatherException(
        message: 'Network error',
        code: 'NETWORK_ERROR',
        originalError: e,
      );
    }
  }

  @override
  Future<WeatherEntity> getWeatherByCity(String cityName) {
    // TODO: implement getWeatherByCity
    throw UnimplementedError();
  }
}

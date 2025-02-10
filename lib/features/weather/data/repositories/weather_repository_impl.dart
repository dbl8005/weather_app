import 'dart:convert';

import 'package:http/http.dart' as http;
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
    const lat = 51.5074;
    const lon = -0.1278;

    try {
      final response = await http
          .get(
            Uri.parse(
              '$baseUrl/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely,alerts',
            ),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw WeatherException(message: 'Request timed out'),
          );

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);
          return WeatherModel.fromJson(data);
        } catch (e) {
          throw WeatherException(
              message: 'Failed to parse response', originalError: e);
        }
      } else if (response.statusCode == 401) {
        throw WeatherException(
            message: 'Invalid API key', code: 'INVALID_API_KEY');
      } else {
        throw WeatherException(
          message: 'Failed to load weather data',
          code: 'HTTP_${response.statusCode}',
        );
      }
    } on WeatherException {
      rethrow;
    } catch (e) {
      throw WeatherException(message: 'Network error', originalError: e);
    }
  }

  @override
  Future<WeatherEntity> getWeatherByCity(String cityName) {
    // TODO: implement getWeatherByCity
    throw UnimplementedError();
  }
}

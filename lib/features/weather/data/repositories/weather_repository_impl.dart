import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/secrets.dart';
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

    final response = await http.get(
      Uri.parse(
        '$baseUrl/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely,daily,alerts',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<WeatherEntity> getWeatherByCity(String cityName) {
    // TODO: implement getWeatherByCity
    throw UnimplementedError();
  }
}

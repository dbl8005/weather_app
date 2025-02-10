import 'dart:convert';

import 'package:weather_app/core/constants/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/errors/weather_exception.dart';

import 'package:weather_app/features/search/data/models/city_model.dart';
import 'package:weather_app/features/search/domain/repositories/search_repository.dart';

class SearchRepoImpl implements SearchRepository {
  final String apiKey = Secrets.openWeatherApiKey;

  final String baseUrlGeo = 'https://api.openweathermap.org/geo/1.0';

  @override
  Future<List<CityModel>> searchCities(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrlGeo/direct?q=$query&limit=5&appid=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((e) => CityModel.fromJson(e)).toList();
      } else {
        throw WeatherException(message: 'Oops! Something went wrong');
      }
    } catch (e) {
      throw WeatherException(message: 'Failed to search cities');
    }
  }
}

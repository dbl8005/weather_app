import 'package:weather_app/features/search/data/models/city_model.dart';

abstract class SearchRepository {
  Future<List<CityModel>> searchCities(String query);
}

part of 'search_cities_bloc.dart';

abstract class SearchCitiesEvent {}

class SearchCities extends SearchCitiesEvent {
  final String query;

  SearchCities({required this.query});
}

class SearchCity extends SearchCitiesEvent {
  final String cityName;

  SearchCity({required this.cityName});
}

class ClearCities extends SearchCitiesEvent {}

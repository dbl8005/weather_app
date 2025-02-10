part of 'search_cities_bloc.dart';

abstract class SearchCitiesState {}

final class SearchCitiesInitial extends SearchCitiesState {}

final class SearchCitiesLoading extends SearchCitiesState {}

final class CitiesLoaded extends SearchCitiesState {
  final List<CityModel> cities;

  CitiesLoaded({required this.cities});
}

class CitiesError extends SearchCitiesState {
  final String message;

  CitiesError({required this.message});
}

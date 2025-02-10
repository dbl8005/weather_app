import 'package:bloc/bloc.dart';
import 'package:weather_app/features/search/data/models/city_model.dart';
import 'package:weather_app/features/search/data/repositories/search_repo_impl.dart';

part 'search_cities_event.dart';
part 'search_cities_state.dart';

class SearchCitiesBloc extends Bloc<SearchCitiesEvent, SearchCitiesState> {
  final searchRepo = SearchRepoImpl();
  SearchCitiesBloc() : super(SearchCitiesInitial()) {
    on<SearchCities>((event, emit) async {
      emit(SearchCitiesLoading());
      try {
        final cities = await searchRepo.searchCities(event.query);
        emit(CitiesLoaded(cities: cities));
      } catch (e) {
        emit(CitiesError(message: e.toString()));
      }
    });

    on<SearchCity>((event, emit) async {
      emit(SearchCitiesLoading());
      try {
        final cities = await searchRepo.searchCities(event.cityName);
        emit(CitiesLoaded(cities: cities));
      } catch (e) {
        emit(CitiesError(message: e.toString()));
      }
    });

    on<ClearCities>((event, emit) {
      emit(SearchCitiesInitial());
    });
  }
}

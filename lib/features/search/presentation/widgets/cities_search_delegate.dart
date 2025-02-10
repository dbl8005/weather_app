import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/search/domain/entities/city_entity.dart';
import 'package:weather_app/features/search/presentation/bloc/search_cities_bloc.dart';

class CitiesSearchDelegate extends SearchDelegate<CityEntity> {
  Timer? _debounce;
  String _lastQuery = '';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocProvider<SearchCitiesBloc>(
      create: (context) => SearchCitiesBloc(),
      child: BlocBuilder<SearchCitiesBloc, SearchCitiesState>(
        builder: (context, state) {
          if (query.isEmpty) {
            context.read<SearchCitiesBloc>().add(ClearCities());
            return const SizedBox.shrink();
          }
          // Debounce the search
          if (query.isNotEmpty && query != _lastQuery) {
            _lastQuery = query;

            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              context.read<SearchCitiesBloc>().add(SearchCities(query: query));
            });
          }

          if (state is SearchCitiesInitial) {
            return Container();
          }

          if (state is SearchCitiesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CitiesLoaded) {
            final cities = state.cities;
            return ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];
                return ListTile(
                  title: Text('${city.name}, ${city.country}'),
                  onTap: () {
                    close(context, city);
                  },
                );
              },
            );
          }
          if (state is CitiesError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

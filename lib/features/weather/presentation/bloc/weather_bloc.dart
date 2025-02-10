import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_app/core/errors/weather_exception.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final weatherRepository = WeatherRepositoryImpl();
  LocationData? lastLocation;
  WeatherEntity? lastWeather;

  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeather>(
      (event, emit) async {
        emit(WeatherLoading());
        try {
          final location = await _getCurrentLocation();
          if (location != null) {
            lastLocation = location;
            final weather = await weatherRepository.getWeatherByLocation(
              location.latitude!,
              location.longitude!,
            );
            lastWeather = weather;
            emit(WeatherLoaded(weather));
          } else {
            // Fallback to default location if permission denied or location unavailable
            final weather = await weatherRepository.getCurrentWeather();
            lastWeather = weather;
            emit(WeatherLoaded(weather));
          }
        } on WeatherException catch (e) {
          emit(WeatherError(e.toString()));
        } catch (e) {
          emit(WeatherError('Failed to fetch weather data'));
        }
      },
    );

    on<GetWeatherByLocation>(
      (event, emit) async {
        emit(WeatherLoading());
        try {
          final weather = await weatherRepository.getWeatherByLocation(
            event.latitude,
            event.longitude,
          );
          lastWeather = weather;
          emit(WeatherLoaded(weather));
        } on WeatherException catch (e) {
          emit(WeatherError(e.toString()));
        } catch (e) {
          emit(WeatherError('Failed to fetch weather data'));
        }
      },
    );

    on<GetWeatherByCity>(
      (event, emit) async {
        emit(WeatherLoading());
        try {
          final weather =
              await weatherRepository.getWeatherByCity(event.cityName);
          lastWeather = weather;
          emit(WeatherLoaded(weather));
        } on WeatherException catch (e) {
          emit(WeatherError(e.toString()));
        } catch (e) {
          emit(WeatherError('Failed to fetch weather data'));
        }
      },
    );

    on<RefreshWeather>(
      (event, emit) async {
        if (lastLocation != null) {
          add(GetWeatherByLocation(
            latitude: lastLocation!.latitude!,
            longitude: lastLocation!.longitude!,
          ));
        } else {
          add(GetWeather());
        }
      },
    );
  }

  Future<LocationData?> _getCurrentLocation() async {
    try {
      final location = Location();
      bool isServiceEnabled = await location.serviceEnabled();
      if (!isServiceEnabled) {
        isServiceEnabled = await location.requestService();
        if (!isServiceEnabled) {
          return null;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }
}

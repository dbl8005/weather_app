part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class GetWeather extends WeatherEvent {}

class GetWeatherByLocation extends WeatherEvent {
  final double latitude;
  final double longitude;

  GetWeatherByLocation({required this.latitude, required this.longitude});
}

class GetWeatherByCity extends WeatherEvent {
  final String cityName;

  GetWeatherByCity({required this.cityName});
}

class RefreshWeather extends WeatherEvent {}

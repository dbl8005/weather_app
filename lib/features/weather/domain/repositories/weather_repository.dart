import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather();
  Future<WeatherEntity> getWeatherByLocation(double latitude, double longitude);
  Future<WeatherEntity> getWeatherByCity(String cityName);
}

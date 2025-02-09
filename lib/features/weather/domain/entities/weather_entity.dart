class WeatherEntity {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final String description;
  final String iconCode;
  final double windSpeed;
  final String cityName;

  WeatherEntity({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.description,
    required this.iconCode,
    required this.windSpeed,
    required this.cityName,
  });
}

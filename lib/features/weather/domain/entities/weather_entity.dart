class WeatherEntity {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final String description;
  final String iconCode;
  final double windSpeed;
  final String cityName;
  final int pressure;
  final double uvi;
  final int clouds;
  final int visibility;
  final double dewPoint;

  WeatherEntity({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.description,
    required this.iconCode,
    required this.windSpeed,
    required this.cityName,
    required this.pressure,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.dewPoint,
  });
}

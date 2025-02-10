class HourlyWeatherEntity {
  final int timestamp;
  final double temperature;
  final String iconCode;

  HourlyWeatherEntity({
    required this.timestamp,
    required this.temperature,
    required this.iconCode,
  });
}

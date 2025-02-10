class DailyWeatherEntity {
  final int timestamp;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double moonPhase;
  final String summary;
  final Map<String, double> temperature;
  final Map<String, double> feelsLike;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final double clouds;
  final double dewPoint;
  final double uvi;
  final double rainProbability;
  final double snowProbability;
  final String iconCode;

  DailyWeatherEntity({
    required this.timestamp,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.summary,
    required this.temperature,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.clouds,
    required this.dewPoint,
    required this.uvi,
    required this.rainProbability,
    required this.snowProbability,
    required this.iconCode,
  });
}

class AppConfig {
  // API URLs
  static const String weatherBaseUrl =
      'https://api.openweathermap.org/data/3.0';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 10);

  // Default location (London)
  static const double defaultLat = 51.5074;
  static const double defaultLon = -0.1278;
}

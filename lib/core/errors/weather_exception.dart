class WeatherException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  WeatherException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() =>
      'WeatherException: $message (Code: ${code != null ? code : 'Unknown'})';
}

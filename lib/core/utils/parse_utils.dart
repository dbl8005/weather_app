class ParseUtils {
  static double toDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return defaultValue;
  }

  static int toInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  static String asString(dynamic value, {String defaultValue = ''}) {
    if (value == null) return defaultValue;
    if (value is String) return value;
    return value.toString();
  }

  static Map<String, double> toDoubleMap(Map<String, dynamic>? json,
      {double defaultValue = 0.0}) {
    if (json == null) return {};
    return json.map((key, value) => MapEntry(
          key,
          toDouble(value, defaultValue: defaultValue),
        ));
  }
}

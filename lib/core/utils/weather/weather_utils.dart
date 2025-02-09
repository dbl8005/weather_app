import 'package:flutter/material.dart';

class WeatherUtils {
  static String getWeatherIcon(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  static LinearGradient getBackgroundGradient(String iconCode) {
    bool isNight = iconCode.endsWith('n');
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: _getGradientColors(isNight, iconCode),
    );
  }

  static List<Color> _getGradientColors(bool isNight, String iconCode) {
    if (isNight) {
      return [
        const Color(0xFF1F1B2E),
        const Color(0xFF16151F),
      ];
    }
    // Different gradients for different weather conditions
    switch (iconCode) {
      case '01d': // clear sky
        return [
          const Color(0xFF4CA1FF),
          const Color(0xFF76C5F9),
        ];
      case '02d': // few clouds
      case '03d': // scattered clouds
      case '04d': // broken clouds
        return [
          const Color(0xFF6EBAE7),
          const Color(0xFF9AC2E1),
        ];
      case '09d': // shower rain
      case '10d': // rain
        return [
          const Color(0xFF4B6982),
          const Color(0xFF7B8C98),
        ];
      case '11d': // thunderstorm
        return [
          const Color(0xFF4A4A4A),
          const Color(0xFF696969),
        ];
      case '13d': // snow
        return [
          const Color(0xFF8AABBD),
          const Color(0xFFB3C8D4),
        ];
      case '50d': // mist
        return [
          const Color(0xFF5C6E80),
          const Color(0xFF7B8C98),
        ];
      default:
        return [
          const Color(0xFF5C6E80),
          const Color(0xFF7B8C98),
        ];
    }
  }
}

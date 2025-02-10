import 'package:flutter/material.dart';

class WeatherUtils {
  static String getWeatherIcon(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@4x.png';
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
      switch (iconCode) {
        case '01n': // clear night
          return [
            const Color(0xFF172941),
            const Color(0xFF1F1B2E),
          ];
        case '02n': // few clouds night
        case '03n': // scattered clouds night
          return [
            const Color(0xFF2C3E50),
            const Color(0xFF1F1B2E),
          ];
        case '04n': // broken clouds night
          return [
            const Color(0xFF2C3E50),
            const Color(0xFF243B55),
          ];
        case '09n': // shower rain night
        case '10n': // rain night
          return [
            const Color(0xFF203A43),
            const Color(0xFF1E1E1E),
          ];
        case '11n': // thunderstorm night
          return [
            const Color(0xFF090909),
            const Color(0xFF1A1A1A),
          ];
        case '13n': // snow night
          return [
            const Color(0xFF2C3E50),
            const Color(0xFF3498DB),
          ];
        case '50n': // mist night
          return [
            const Color(0xFF364F6B),
            const Color(0xFF202020),
          ];
        default: // default night
          return [
            const Color(0xFF1F1B2E),
            const Color(0xFF16151F),
          ];
      }
    } else {
      // Day gradients
      switch (iconCode) {
        case '01d': // clear sky
          return [
            const Color(0xFF4CA1FF), // bright blue
            const Color(0xFF76C5F9), // light blue
          ];
        case '02d': // few clouds
          return [
            const Color(0xFF6FB1FC), // soft blue
            const Color(0xFF9AC2E1), // lighter blue
          ];
        case '03d': // scattered clouds
          return [
            const Color(0xFF8EC5FC), // light blue
            const Color(0xFFE0C3FC), // light purple
          ];
        case '04d': // broken clouds
          return [
            const Color(0xFF89A7C2), // grayish blue
            const Color(0xFFB8D0E1), // light grayish blue
          ];
        case '09d': // shower rain
          return [
            const Color(0xFF5B86A6), // steel blue
            const Color(0xFF7DA2BB), // lighter steel blue
          ];
        case '10d': // rain
          return [
            const Color(0xFF4B6982), // dark blue gray
            const Color(0xFF7B8C98), // light blue gray
          ];
        case '11d': // thunderstorm
          return [
            const Color(0xFF4A4A4A), // dark gray
            const Color(0xFF696969), // medium gray
          ];
        case '13d': // snow
          return [
            const Color(0xFFB8D0E1), // very light blue
            const Color(0xFFE6EEF4), // almost white blue
          ];
        case '50d': // mist
          return [
            const Color(0xFF8FA3B3), // misty blue
            const Color(0xFFB4C4D1), // light misty blue
          ];
        default: // default day
          return [
            const Color(0xFF4CA1FF),
            const Color(0xFF76C5F9),
          ];
      }
    }
  }
}

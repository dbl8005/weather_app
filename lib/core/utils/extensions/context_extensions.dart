import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  // Theme extensions
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Media Query extensions
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenHeight => mediaQuery.size.height;
  double get screenWidth => mediaQuery.size.width;
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  // Padding & Margin helpers
  EdgeInsets get padding => mediaQuery.padding;
  double get bottomPadding => mediaQuery.padding.bottom;
  double get topPadding => mediaQuery.padding.top;

  // Responsive breakpoints
  bool get isMobile => screenWidth < 650;
  bool get isTablet => screenWidth >= 650 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // Navigation helper
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  // Snackbar helper
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class AppConstants {
  // App specific
  static const String appName = 'Your App Name';
  static const String appVersion = '1.0.0';

  // API related
  static const String baseUrl = 'https://api.yourapp.com';
  static const int apiTimeout = 30000; // 30 seconds

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  // Animation
  static const int defaultAnimationDuration = 300; // milliseconds

  // Pagination
  static const int defaultPageSize = 20;
  static const int defaultPageNumber = 1;

  // Cache
  static const int defaultCacheAge = 3600; // 1 hour in seconds

  // Assets
  static const String imagePath = 'assets/images';
  static const String iconPath = 'assets/icons';
}

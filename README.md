# Weather App 🌤️

A Flutter-based weather application that provides real-time weather information.

## Architecture & Technologies

### Core Technologies
- **Flutter/Dart**: Cross-platform UI framework
- **BLoC**: State management solution
- **Firebase**: Backend services and analytics
- **Geolocator**: Location services integration

### Architecture
- **Clean Architecture**: Domain, Data, and Presentation layers
- **MVVM Pattern**: Separation of UI and business logic
- **Feature-First**: Organized by features instead of layers

### Key Components
- **Domain Layer**: Business logic and entities
- **Data Layer**: Repository implementations and data sources
- **Presentation Layer**: BLoC, UI widgets, and screens
- **Feature Modules**: Weather, Location, Settings

### Firebase Services
- Authentication
- Cloud Firestore
- Analytics
- Crashlytics

## Features

- Real-time weather updates
- Location-based forecasts
- User authentication
- Offline support
- Multiple location tracking

## Installation

1. Clone the repository
```bash
git clone https://github.com/dbl8005/weather_app.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
- Add `google-services.json` (Android)
- Add `GoogleService-Info.plist` (iOS)

4. Run the app
```bash
flutter run
```



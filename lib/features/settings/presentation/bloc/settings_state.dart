part of 'settings_bloc.dart';

enum TemperatureUnit { celsius, fahrenheit }

class SettingsState extends Equatable {
  final TemperatureUnit unit;

  const SettingsState(this.unit);

  @override
  List<Object> get props => [unit];
}

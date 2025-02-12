part of 'settings_bloc.dart';

enum unitsFormat { metric, imperial }

class SettingsState extends Equatable {
  final unitsFormat unit;

  const SettingsState(this.unit);

  @override
  List<Object> get props => [unit];
}

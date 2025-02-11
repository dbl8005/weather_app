import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const String _unitKey = "temperature_unit";

  SettingsBloc() : super(const SettingsState(TemperatureUnit.celsius)) {
    _loadSettings(); // Load the unit from storage when bloc starts

    on<ToggleUnit>((event, emit) async {
      final newUnit = state.unit == TemperatureUnit.celsius
          ? TemperatureUnit.fahrenheit
          : TemperatureUnit.celsius;

      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_unitKey, newUnit == TemperatureUnit.fahrenheit);

      emit(SettingsState(newUnit)); // Update UI
    });
  }

  // Load saved unit preference
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isFahrenheit = prefs.getBool(_unitKey) ?? false;
    add(ToggleUnit()); // Trigger state update based on stored value
  }
}

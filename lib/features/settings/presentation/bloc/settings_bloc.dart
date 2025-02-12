import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const String _unitKey = "units_format";

  SettingsBloc() : super(const SettingsState(unitsFormat.metric)) {
    _loadSettings(); // Load the unit from storage when bloc starts

    on<ToggleUnit>((event, emit) async {
      final newUnit = state.unit == unitsFormat.metric
          ? unitsFormat.imperial
          : unitsFormat.metric;

      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_unitKey, newUnit == unitsFormat.imperial);

      emit(SettingsState(newUnit)); // Update UI
    });
  }

  // Load saved unit preference
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isImperial = prefs.getBool(_unitKey) ?? false;
    final unit = isImperial ? unitsFormat.imperial : unitsFormat.metric;
    emit(SettingsState(unit));
  }
}

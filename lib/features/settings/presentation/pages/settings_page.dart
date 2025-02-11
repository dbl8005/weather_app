import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/extensions/context_extensions.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_background_wrapper.dart';

class SettingsPage extends StatefulWidget {
  final String weatherCode;
  const SettingsPage({super.key, required this.weatherCode});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return WeatherBackgroundWrapper(
      weatherCode: widget.weatherCode,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text('Use Celsius',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          )),
                      value: state.unit == TemperatureUnit.celsius,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(ToggleUnit());
                        print('Temperature unit toggled to: $value');
                      },
                    ),
                    Divider(color: Colors.white.withOpacity(0.1)),
                    SwitchListTile(
                      title: Text('24-Hour Time Format',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          )),
                      value: false,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              );
            },
          ),
          Text('Version: 1.0.0'),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/extensions/context_extensions.dart';
import 'package:weather_app/core/utils/weather/weather_utils.dart';
import 'package:weather_app/core/widgets/common/app_error.dart';
import 'package:weather_app/core/widgets/common/app_loading.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_info_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc()..add(GetWeather()),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                if (state is WeatherLoaded)
                  Container(
                    decoration: BoxDecoration(
                      gradient: WeatherUtils.getBackgroundGradient(
                          state.weather.iconCode),
                    ),
                  ),
                SafeArea(
                  child: Column(
                    children: [
                      AppBar(
                        title: Text(
                          'Current Weather',
                          style: TextStyle(
                            color: context.theme.colorScheme.surface,
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      Expanded(child: _buildContent(context, state)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, WeatherState state) {
    if (state is WeatherLoading) {
      return AppLoading(
        color: context.theme.colorScheme.onSurface,
      );
    }
    if (state is WeatherError) {
      return AppError(
        message: state.message,
        onRetry: () => context.read<WeatherBloc>().add(GetWeather()),
      );
    }
    if (state is WeatherLoaded) {
      return WeatherInfoWidget(weather: state.weather);
    }
    return const SizedBox.shrink();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:units_converter/models/extension_converter.dart';
import 'package:units_converter/properties/temperature.dart';
import 'package:weather_app/core/utils/weather/weather_convertors.dart';
import 'package:weather_app/core/utils/weather/weather_utils.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:weather_app/features/weather/presentation/pages/daily_forecast_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/hourly_weather_card.dart';
import '../../domain/entities/weather_entity.dart';

class WeatherInfoWidget extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherInfoWidget({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final isCelsius = state.unit == TemperatureUnit.celsius;
        return Container(
          decoration: BoxDecoration(
            gradient: WeatherUtils.getBackgroundGradient(weather.iconCode),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildMainInfo(context),
                const SizedBox(height: 20),
                _buildPrimaryDetails(context),
                const SizedBox(height: 20),
                _buildSecondaryDetails(context),
                const SizedBox(height: 20),
                _buildHourlyWeather(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 10),
        Image.network(
          WeatherUtils.getWeatherIcon(weather.iconCode),
          width: 100,
          height: 100,
        ),
        Text(
          WeatherConvertors().formatTemperature(weather.temperature, context),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        Text(
          weather.description.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white70,
              ),
        ),
      ],
    );
  }

  Widget _buildPrimaryDetails(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDetailColumn(
            context,
            'Feels Like',
            WeatherConvertors().formatTemperature(weather.feelsLike, context),
            Icons.thermostat,
          ),
          _buildDetailColumn(
            context,
            'Humidity',
            '${weather.humidity}%',
            Icons.water_drop,
          ),
          _buildDetailColumn(
            context,
            'Wind',
            '${weather.windSpeed} m/s',
            Icons.air,
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryDetails(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDetailColumn(
                context,
                'UV Index',
                weather.uvi.toStringAsFixed(1),
                Icons.wb_sunny,
              ),
              _buildDetailColumn(
                context,
                'Pressure',
                '${weather.pressure} hPa',
                Icons.speed,
              ),
              _buildDetailColumn(
                context,
                'Visibility',
                WeatherConvertors()
                    .formatDistance(weather.visibility.toDouble(), context),
                Icons.visibility,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDetailColumn(
                context,
                'Clouds',
                '${weather.clouds}%',
                Icons.cloud,
              ),
              _buildDetailColumn(
                context,
                'Dew Point',
                '${weather.dewPoint.round()}°C',
                Icons.opacity,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final String tooltip = _getTooltipText(label);
    return Tooltip(
      message: tooltip,
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyWeather(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weather.hourlyWeather.length,
        itemBuilder: (context, index) {
          return HourlyWeatherCard(
            weather: weather.hourlyWeather[index],
            isNow: index == 0,
          );
        },
      ),
    );
  }

  String _getTooltipText(String label) {
    switch (label) {
      case 'Feels Like':
        return 'The perceived temperature, taking into account humidity and wind';
      case 'Humidity':
        return 'The amount of water vapor in the air';
      case 'Wind':
        return 'Wind speed in meters per second';
      case 'UV Index':
        return 'Ultraviolet radiation intensity level';
      case 'Pressure':
        return 'Atmospheric pressure in hectopascals (hPa)';
      case 'Visibility':
        return 'Maximum visibility distance in kilometers';
      case 'Clouds':
        return 'Percentage of sky covered by clouds';
      case 'Dew Point':
        return 'Temperature at which water vapor starts to condense';
      default:
        return '';
    }
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:weather_app/core/utils/extensions/context_extensions.dart';
import 'package:weather_app/features/search/presentation/widgets/cities_search_delegate.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/pages/daily_forecast_page.dart';
import 'package:weather_app/features/weather/presentation/pages/current_weather_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_background_wrapper.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc()..add(GetWeather()),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          bool currentLocation = context.read<WeatherBloc>().useCurrentLocation;
          String weatherCode = '01d'; // default sunny day
          if (state is WeatherLoaded) {
            weatherCode = state.weather.iconCode;
          }

          return WeatherBackgroundWrapper(
            weatherCode: weatherCode,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                actions: [
                  currentLocation
                      ? SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            context.read<WeatherBloc>()
                              ..useCurrentLocation = true
                              ..add(GetWeather());
                          },
                          icon: Icon(
                            Icons.my_location,
                            color: Colors.white,
                          ),
                        ),
                  IconButton(
                    onPressed: () async {
                      final selectedCity = await showSearch(
                        context: context,
                        delegate: CitiesSearchDelegate(),
                      );
                      if (selectedCity != null) {
                        if (context.mounted) {
                          context.read<WeatherBloc>().add(
                                GetWeatherByLocation(
                                  latitude: selectedCity.latitude,
                                  longitude: selectedCity.longitude,
                                ),
                              );
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
                backgroundColor: Colors.transparent,
                title: Text(
                  switch (_selectedIndex) {
                    0 => 'Current Weather',
                    1 => '7 Days Forecast',
                    _ => 'Weather App',
                  },
                  style: TextStyle(
                    color: context.theme.colorScheme.surface,
                  ),
                ),
                elevation: 0,
              ),
              body: IndexedStack(
                index: _selectedIndex,
                children: [
                  CurrentWeatherPage(),
                  if (state is WeatherLoaded)
                    DailyForecastPage(
                      dailyWeather: state.weather.dailyWeather,
                      cityName: state.weather.cityName,
                    )
                  else
                    const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                ],
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: GNav(
                    color: Colors.white.withOpacity(0.7),
                    activeColor: Colors.white,
                    tabBackgroundColor: Colors.white.withOpacity(0.1),
                    gap: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    tabs: const [
                      GButton(
                        icon: Icons.cloud_outlined,
                        text: 'Current',
                      ),
                      GButton(
                        icon: Icons.calendar_today_outlined,
                        text: '7 Days',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

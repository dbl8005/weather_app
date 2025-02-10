import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:weather_app/core/utils/extensions/context_extensions.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/pages/daily_forecast_page.dart';
import 'package:weather_app/features/weather/presentation/pages/current_weather_page.dart';

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
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                _selectedIndex == 0 ? 'Current Weather' : '7 Days Forecast',
                style: TextStyle(
                  color: context.theme.colorScheme.surface,
                ),
              ),
              elevation: 0,
            ),
            extendBody: true,
            extendBodyBehindAppBar: true,
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
          );
        },
      ),
    );
  }
}

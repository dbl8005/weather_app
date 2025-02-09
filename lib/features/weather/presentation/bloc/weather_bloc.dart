import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final weatherRepository = WeatherRepositoryImpl();

  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeather>(
      (event, emit) async {
        emit(WeatherLoading());
        try {
          final weather = await weatherRepository.getCurrentWeather();
          emit(WeatherLoaded(weather));
        } catch (e) {
          emit(WeatherError(e.toString()));
        }
      },
    );
  }
}

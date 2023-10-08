import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit/weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weather) : super(IntialWeatherState());
  WeatherService weather;
  String? cityName;
  WeatherModel? weatherModel;
  void getWeather({required String city}) async {
    emit(LoadingWeatherState());
    try {
      weatherModel = await weather.getWeather(cityName: city);
      emit(SuccessWeatherState());
    } catch (e) {
      emit(FailWeatherState());
    }
  }
}

part of 'current_day_weather_cubit.dart';

abstract class CurrentDayWeatherState extends Equatable {
  const CurrentDayWeatherState();
}

class CurrentDayWeatherInitial extends CurrentDayWeatherState {
  @override
  List<Object> get props => [];
}
class CurrentDayWeatherLoading extends CurrentDayWeatherState {
  @override
  List<Object> get props => [];
}
class CurrentDayWeatherSuccess extends CurrentDayWeatherState {
  final CurrentWeatherModel currentWeatherModel;

  CurrentDayWeatherSuccess({required this.currentWeatherModel});
  @override
  List<Object> get props => [];
}
class CurrentDayWeatherNoInternet extends CurrentDayWeatherState {
  @override
  List<Object> get props => [];
}
class CurrentDayWeatherTimeOut extends CurrentDayWeatherState {
  @override
  List<Object> get props => [];
}
class CurrentDayWeatherException extends CurrentDayWeatherState {
  @override
  List<Object> get props => [];
}

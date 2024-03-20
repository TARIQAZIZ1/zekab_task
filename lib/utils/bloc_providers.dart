import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zekab_task/cubits/current_day_weather_cubit/current_day_weather_cubit.dart';
import 'package:zekab_task/data/repositories/current_day_weather_repository.dart';
class BlocProviders {
  static final List<BlocProvider> providers = [

    BlocProvider<CurrentDayWeatherCubit>(
      create: (context) => CurrentDayWeatherCubit(GetCurrentDayWeatherRepository()),
    ),
  ];
}
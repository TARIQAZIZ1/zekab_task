import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zekab_task/data/models/current_day_weather_model.dart';
import 'package:zekab_task/utils/app_strings.dart';
import '../../data/repositories/current_day_weather_repository.dart';
part 'current_day_weather_state.dart';

class CurrentDayWeatherCubit extends Cubit<CurrentDayWeatherState> {
  GetCurrentDayWeatherRepository getCurrentDayWeatherRepository;
  CurrentDayWeatherCubit(this.getCurrentDayWeatherRepository) : super(CurrentDayWeatherInitial());
  getCurrentDayWeather({required String lat, required String lon,}) async{
    try{
      emit(CurrentDayWeatherLoading());
      var apiResponse = await getCurrentDayWeatherRepository.getCurrentDayWeather(lat: lat, lon: lon);
      if(apiResponse is CurrentWeatherModel){
        emit(CurrentDayWeatherSuccess(currentWeatherModel: apiResponse));
      }else if(apiResponse is String){
        if(apiResponse == AppStrings.connectionTimeOut){
          emit(CurrentDayWeatherNoInternet());
        }else if(apiResponse == AppStrings.timeOut.toString()){
          emit(CurrentDayWeatherTimeOut());
        }
      }else{
        emit(CurrentDayWeatherException());
      }
    }catch(e){
      emit(CurrentDayWeatherException());
    }
  }
}

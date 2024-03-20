import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zekab_task/data/models/current_day_weather_model.dart';
import '../../api_config/api_address.dart';
import '../../api_config/api_routes.dart';
import '../../utils/app_strings.dart';

abstract class GetCurrentDayWeather {
  Future<dynamic> getCurrentDayWeather(
  {required String lat, required String lon,});
}

class GetCurrentDayWeatherRepository implements GetCurrentDayWeather {
  @override
  Future<dynamic> getCurrentDayWeather({required String lat, required String lon,}) async {
    try {
      final String getCurrentDayRoute =
      await ApiRoutes.currentDayApiRoute(lat: lat, lon: lon);
      final url = Uri.parse('${ApiAddress.ipAddress}$getCurrentDayRoute');
      var response = await http
          .get(url)
          .timeout(const Duration(seconds: AppStrings.timeOut));
      if (response.statusCode == 200) {
        return CurrentWeatherModel.fromRawJson(response.body);
      }else {
        return response.body;
      }
    } on SocketException catch (_) {
      return AppStrings.connectionTimeOut;
    } on TimeoutException catch (_) {
      return AppStrings.timeOut.toString();
    } catch (e) {
      return e.toString();
    }
   }
}
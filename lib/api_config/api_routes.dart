class ApiRoutes{
  static Future<String> currentDayApiRoute({required String lat, required String lon}) async {
    return '/forecast?latitude=$lat&longitude=$lon&'
        'current=temperature_2m,wind_speed_10m,relative_humidity_2m,precipitation_probability&'
        'hourly=temperature_2m,relative_humidity_2m,wind_speed_10m,precipitation_probability&interval=hours'
        '&timezone=Asia/Karachi';
  }
}
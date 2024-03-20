import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zekab_task/data/models/current_day_weather_model.dart';
import 'package:zekab_task/view/custom_widgets/current_day_custom_widget.dart';
import 'package:intl/intl.dart';
import '../../utils/app_colors.dart';
import '../custom_widgets/day_forecasts_custom_widget.dart';

class OneWeekForeCasteScreen extends StatefulWidget {
  const OneWeekForeCasteScreen({Key? key, required this.currentWeatherModel}) : super(key: key);
  final CurrentWeatherModel currentWeatherModel;

  @override
  State<OneWeekForeCasteScreen> createState() => _OneWeekForeCasteScreenState();
}

class _OneWeekForeCasteScreenState extends State<OneWeekForeCasteScreen> {
  List<String> dayList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateDays();
  }
  ///calculate one week forecast data from retrieved data
  calculateDays(){
    dayList = widget.currentWeatherModel.hourly!.time!.map((timeString) {
      DateTime dateTime = DateTime.parse(timeString);
      return DateFormat('yyyy-MM-dd').format(dateTime); // Format to get only the day
    }).toSet().toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPinkColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 18.w,
          ),
          child: Column(
            children: [
              Expanded(
                child: Text('7-Days',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Expanded(
                flex: 13,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40.h),
                        height: 300.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10.r),

                        ),
                      ),
                      Positioned(
                        top: 100.h,
                        left: 40.w,
                        child:RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.currentWeatherModel.hourly!.temperature2M![24].toString(),
                                style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 70,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: widget.currentWeatherModel.hourlyUnits!.temperature2M!,
                                style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                      Positioned(
                        top: 120.h,
                        left: 200.w,
                        child:const Text('Tomorrow',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ), ),),
                      Positioned(
                        left: 10.w,
                        right: 10.w,
                        bottom: 30.h,
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CurrentDayCustomWidget(
                                  icon: Icons.umbrella_outlined,
                                  title: 'Participation',
                                  value: '${widget.currentWeatherModel.hourly!.precipitationProbability![24]}%',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CurrentDayCustomWidget(
                                  icon: Icons.water_drop,
                                  title: 'Humidity',
                                  value: '${widget.currentWeatherModel.hourly!.relativeHumidity2M![24]}%',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CurrentDayCustomWidget(
                                  icon: Icons.wind_power,
                                  title: 'Wind Speed',
                                  value: '${widget.currentWeatherModel.hourly!.windSpeed10M![24]} km/h',
                                ),
                              ),
                            ),
                          ],
                        ),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              Expanded(
                flex: 11,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 7,
                  padding: const EdgeInsets.symmetric(),
                  itemBuilder: (BuildContext context, int index) {
                    // Get the start and end index for temperatures of the current day
                    int startIndex = index * 24; // 24 hours per day
                    int endIndex = (index + 1) * 24; // Exclusive
                    // Calculate the average temperature for the day
                    List<double> temperaturesOfDay = widget.currentWeatherModel.hourly!.temperature2M!.sublist(startIndex, endIndex);
                    double averageTemperature = temperaturesOfDay.reduce((a, b) => a + b) / temperaturesOfDay.length;
                    // Parse the date to get the day name
                    DateTime dateTime = DateTime.parse(widget.currentWeatherModel.hourly!.time![startIndex]);
                    String dayName = DateFormat('EEEE').format(dateTime);
                    return DayForecastsCustomWidget(
                      day: dayName,
                      type: '',
                      value: '${averageTemperature.toStringAsFixed(2)}${widget.currentWeatherModel.hourlyUnits!.temperature2M![0]}',
                    );
                  },
                  separatorBuilder: (context, index){
                    return SizedBox(height: 10.h,);
                  },
              ),),
            ],
          ),
        ),
      ),
    );
  }
}



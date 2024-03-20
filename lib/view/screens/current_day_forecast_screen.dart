import 'package:flutter/material.dart';
import 'package:zekab_task/cubits/current_day_weather_cubit/current_day_weather_cubit.dart';
import 'package:zekab_task/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zekab_task/view/custom_widgets/custom_methods.dart';
import 'package:zekab_task/view/custom_widgets/get_current_location_method.dart';
import 'package:zekab_task/view/custom_widgets/screenshot_functionality.dart';
import 'package:zekab_task/view/screens/oneweek_forecaste_report_screen.dart';
import '../custom_widgets/current_day_custom_widget.dart';
import '../custom_widgets/hourly_weather_report_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';

class CurrentDayWeather extends StatefulWidget {
  const CurrentDayWeather({Key? key}) : super(key: key);

  @override
  State<CurrentDayWeather> createState() => _CurrentDayWeatherState();
}

class _CurrentDayWeatherState extends State<CurrentDayWeather> {
  late CurrentDayWeatherCubit currentDayWeatherCubit;

  @override
  void initState() {
    super.initState();
    currentDayWeatherCubit = context.read<CurrentDayWeatherCubit>();
    initFunction();
  }

  initFunction() async {
    await GetCurrentLocation.getLocation().then((value) {
      return {
        currentDayWeatherCubit.getCurrentDayWeather(
          lat: value.latitude.toString(),
          lon: value.longitude.toString(),
        )
      };
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /// Capture the screen
          String? imagePath = await TakeScreenShot.captureScreen();
          if (imagePath != null) {
            /// Crop and share the captured image
            await TakeScreenShot.cropper(imagePath);
          } else {

          }
        },
        tooltip: 'Capture, Crop, and Share',
        child: const Icon(Icons.camera),
      ),

      backgroundColor: AppColors.primaryColor,
      body: Screenshot(
        controller: TakeScreenShot.controller,
        child: SafeArea(
          child: BlocBuilder<CurrentDayWeatherCubit, CurrentDayWeatherState>(
            builder: (context, state) {
              ///current and loading state
              if (state is CurrentDayWeatherLoading ||
                  state is CurrentDayWeatherInitial) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  ),
                );
              }

              ///if api is called successfully
              else if (state is CurrentDayWeatherSuccess) {
                final data = state.currentWeatherModel;
                ///getting formatted date and time
                DateTime dateTime =
                    DateTime.parse(state.currentWeatherModel.current!.time!);
                String formattedDateTime =
                    DateFormat('EEEE, dd MMMM | hh:mm a').format(dateTime);

                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 18.w,
                  ),
                  children: [
                    Text(
                      GetCurrentLocation.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: data.current!.temperature2M
                                .toString(),
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 170,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: data.currentUnits!.temperature2M
                                .toString(),
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ])),
                    Text(
                      formattedDateTime.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: 100.h,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade900,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CurrentDayCustomWidget(
                                icon: Icons.umbrella_outlined,
                                title: 'Participation',
                                value:
                                    '${data.current!.precipitationProbability}%',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CurrentDayCustomWidget(
                                icon: Icons.water_drop,
                                title: 'Humidity',
                                value:
                                    '${data.current!.relativeHumidity2M}%',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CurrentDayCustomWidget(
                                icon: Icons.wind_power,
                                title: 'Wind Speed',
                                value: '${data.current!.windSpeed10M} km/h',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Today',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OneWeekForeCasteScreen(
                                      currentWeatherModel:
                                          data,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                '7-Days Forecasts',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80.h,
                      width: 1.sw,
                      child: ListView.builder(
                        itemCount: 12,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = state.currentWeatherModel;
                          DateTime currentTime = DateTime.now();
                          DateTime dateTime = DateTime.parse(data.hourly!.time![index]);

                          if (currentTime.hour > dateTime.hour) {
                            String formattedTime =
                                DateFormat('h:mm p').format(dateTime);
                            return Align(
                              child: Container(
                                height: 80.h,
                                width: 50.w,
                                margin: EdgeInsets.only(
                                  right: 20.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade900,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: HourlyWeatherReportWidget(
                                  time: formattedTime,
                                  value:
                                      '${data.hourly!.temperature2M![index].toString()}c',
                                  icon: CustomMethods.getIcon(data.hourly!.temperature2M![index]),
                                ),
                              ),
                            );
                          } else {
                            // If the hour is past the current hour, return an empty container
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                );
              }

              ///if there is some issue with api call
              else {
                return Center(
                  child: Text(
                    'Something went wrong',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

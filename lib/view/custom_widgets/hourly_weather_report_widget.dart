import 'package:flutter/cupertino.dart';

import '../../utils/app_colors.dart';

class HourlyWeatherReportWidget extends StatelessWidget {
  const HourlyWeatherReportWidget({
    super.key, required this.time, required this.value, required this.icon,
  });
  final String time;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(time,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),),
        Expanded(child: Icon(icon,
          color: AppColors.whiteColor,
        )),
        Expanded(child: Text(value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),),
      ],
    );
  }
}
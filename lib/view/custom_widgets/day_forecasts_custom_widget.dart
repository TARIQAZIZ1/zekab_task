import 'package:flutter/cupertino.dart';

import '../../utils/app_colors.dart';

class DayForecastsCustomWidget extends StatelessWidget {
  const DayForecastsCustomWidget({
    super.key, required this.day, required this.value, required this.type,
  });
  final String day;
  final String value;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(day,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          child: Text(type,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          child: Text(value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
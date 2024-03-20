import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class CurrentDayCustomWidget extends StatelessWidget {
  const CurrentDayCustomWidget({
    required this.title, required this.icon, required this.value,
    super.key,
  });
  final IconData icon;
  final String value;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(icon,))),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
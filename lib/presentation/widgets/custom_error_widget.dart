import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_nti/core/theme/colors.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/no_results.svg",
            width: 250.w,
            height: 250.h,
            fit: BoxFit.contain,
          ),

          Text(
            errorMessage,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: isDark(context) ? myWhite : myBlack,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_nti/core/theme/colors.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({
    super.key,
    required this.cityName,
    required this.countryName,
  });

  final String cityName;
  final String countryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color:
              isDark(context)
                  ? const Color.fromARGB(55, 255, 255, 255)
                  : const Color.fromARGB(123, 255, 255, 255),
          borderRadius: BorderRadius.circular(16),
        ),
        height: 50.h,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "$cityName, $countryName",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: isDark(context) ? myWhite : myBlack,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              isDark(context)
                  ? "assets/images/arrow_right_white.svg"
                  : "assets/images/arrow_right_black.svg",
              width: 15.h,
              height: 15.h,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}

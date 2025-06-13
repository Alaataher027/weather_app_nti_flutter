import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_nti/core/theme/colors.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';
import 'package:weather_app_nti/presentation/widgets/search_widgets/search_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            isDark(context)
                ? const Color.fromARGB(255, 55, 91, 126)
                : const Color.fromARGB(255, 220, 233, 249),
        appBar: AppBar(
          backgroundColor:
              isDark(context)
                  ? const Color.fromARGB(255, 55, 91, 126)
                  : const Color.fromARGB(255, 220, 233, 249),
          title: Text(
            "Search",
            style: TextStyle(
              fontSize: 20.sp,
              color: myTextColor(context),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: const SearchBody(),
      ),
    );
  }
}

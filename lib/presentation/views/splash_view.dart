import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_nti/core/theme/colors.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';
import 'package:weather_app_nti/presentation/views/home_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeView()));
    });
    return Scaffold( 
      backgroundColor:
          isDark(context)
              ? const Color(0xFF1A3B5A)
              : const Color.fromARGB(255, 128, 194, 247),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/logo.svg",
              width: 200.w,
              height: 200.h,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Weather App',
              style: TextStyle(
                fontSize: 24,
                color: myWhite,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

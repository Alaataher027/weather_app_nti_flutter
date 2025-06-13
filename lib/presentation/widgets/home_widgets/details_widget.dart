import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_nti/core/theme/colors.dart';
import 'package:weather_app_nti/data/models/forecast_model/weather_model.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/current_location_provider.dart';
import 'package:weather_app_nti/presentation/providers/weather_providers/weather_forecast_provider.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/selected_location_provider.dart';
import 'package:weather_app_nti/presentation/widgets/custom_error_widget.dart';
import 'package:weather_app_nti/presentation/widgets/custom_loading.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color:
            isDark(context)
                ? const Color.fromARGB(39, 255, 255, 255)
                : const Color.fromARGB(60, 58, 84, 116),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Consumer(
        builder: (context, ref, child) {
          final currentLocation = ref.watch(currentLocationProvider);
          final selectedLocation = ref.watch(selectedLocationProvider);

          if (selectedLocation != null) {
            final selectedWeather = ref.watch(
              weatherForecastProvider(selectedLocation),
            );

            return selectedWeather.when(
              data: (either) {
                return either.fold(
                  (failure) {
                    return CustomErrorWidget(errorMessage: failure.errMessage);
                  },
                  (data) {
                    return rowDetails(data);
                  },
                );
              },
              loading:
                  () => const Center(
                    child: CustomLoading(width: 250, height: 250),
                  ),
              error: (error, stackTrace) {
                print(error);
                return Center(
                  child: CustomErrorWidget(errorMessage: error.toString()),
                );
              },
            );
          } else {
            return currentLocation.when(
              data: (location) {
                final currentProvider = ref.watch(
                  weatherForecastProvider(location),
                );

                return  currentProvider.when(
                  data: (either) {
                    return either.fold(
                      (failure) {
                        return CustomErrorWidget(
                          errorMessage: failure.errMessage,
                        );
                      },
                      (data) {
                        return  rowDetails(data);
                      },
                    );
                  },
                  loading:
                      () => const Center(
                        child: CustomLoading(width: 250, height: 250),
                      ),
                  error: (error, stackTrace) {
                    print(error);
                    return  Center(
                      child: CustomErrorWidget(errorMessage: error.toString()),
                    );
                  },
                );
              },
              loading:
                  () => const Center(
                    child: CustomLoading(width: 250, height: 250),
                  ),
              error: (error, stackTrace) {
                print(error);
                return Center(
                  child: CustomErrorWidget(errorMessage: error.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }

  Row rowDetails(WeatherModel data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Maxtemp',
              style: TextStyle(
                fontSize: 14.sp,
                color: myWhite,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            SvgPicture.asset(
              "assets/images/temp_in_dark.svg",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10.h),
            Text(
              "${data.maxTemp}°C",
              style: TextStyle(
                color: myWhite,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Humidity',
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: myWhite,
              ),
            ),
            SizedBox(height: 10.h),
            SvgPicture.asset(
              "assets/images/humidity_dark.svg",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10.h),
            Text(
              "${data.humidity}%",
              style: TextStyle(
                color: myWhite,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Wind K/P',
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: myWhite,
              ),
            ),
            SizedBox(height: 10.h),
            SvgPicture.asset(
              "assets/images/wind_dark.svg",
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10.h),
            Text(
              "${data.windKPH}",
              style: TextStyle(
                color: myWhite,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Mintemp',
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: myWhite,
              ),
            ),
            SizedBox(height: 10.h),
            SvgPicture.asset(
              "assets/images/temp_dec_dark.svg",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10.h),
            Text(
              "${data.minTemp}°C",
              style: TextStyle(
                color: myWhite,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_nti/core/theme/colors.dart';
import 'package:weather_app_nti/helper/functions/icons_functions.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/current_location_provider.dart';
import 'package:weather_app_nti/presentation/providers/weather_providers/next_days_weather_provider.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/selected_location_provider.dart';
import 'package:weather_app_nti/presentation/widgets/custom_error_widget.dart';
import 'package:weather_app_nti/presentation/widgets/custom_loading.dart';

class NextDaysWeather extends StatelessWidget {
  const NextDaysWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            isDark(context)
                ? const Color.fromARGB(39, 255, 255, 255)
                : const Color.fromARGB(60, 58, 84, 116),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Consumer(
        builder: (context, ref, child) {
          final location = ref.watch(currentLocationProvider);
          final selectedLocation = ref.watch(selectedLocationProvider);

          if (selectedLocation != null) {
            final selectedWeather = ref.watch(
              nextDaysWeatherPeovider(selectedLocation),
            );
            return selectedWeather.when(
              data: (either) {
                return either.fold(
                  (failure) => Center(
                    child: CustomErrorWidget(
                      errorMessage: failure.errMessage.toString(),
                    ),
                  ),
                  (data) => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final weather = data[index];
                      return Row(
                        children: [
                          Text(
                            weather.date,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: myWhite,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            getHourlyWeatherIcon(weather.weatherCondition),
                            width: 50.h,
                            height: 50.h,
                            fit: BoxFit.fill,
                          ),
                          const Spacer(),
                          Text(
                            "${weather.minTemp.toInt()} / ${weather.maxTemp.toInt()} °C",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: myWhite,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
              loading:
                  () => const Center(
                    child: CustomLoading(width: 150, height: 150),
                  ),
              error: (error, stackTrace) {
                print(error);
                return Center(
                  child: CustomErrorWidget(errorMessage: error.toString()),
                );
              },
            );
          }

          return location.when(
            data: (location) {
              final nextDaysProvider = ref.watch(
                nextDaysWeatherPeovider(location),
              );
              return nextDaysProvider.when(
                data: (either) {
                  return either.fold(
                    (failure) => Center(
                      child: CustomErrorWidget(
                        errorMessage: failure.errMessage.toString(),
                      ),
                    ),
                    (data) => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final weather = data[index];
                        return Row(
                          children: [
                            Text(
                              weather.date,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: myWhite,
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              getHourlyWeatherIcon(weather.weatherCondition),
                              width: 50.h,
                              height: 50.h,
                              fit: BoxFit.fill,
                            ),
                            const Spacer(),
                            Text(
                              "${weather.minTemp.toInt()} / ${weather.maxTemp.toInt()} °C",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: myWhite,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ); //
                },
                loading:
                    () => const Center(
                      child: CustomLoading(width: 150, height: 150),
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
                () =>
                    const Center(child: CustomLoading(width: 150, height: 150)),
            error: (error, stackTrace) {
              print(error);
              return Center(
                child: CustomErrorWidget(errorMessage: error.toString()),
              );
            },
          );
        },
      ),
    );
  }
}

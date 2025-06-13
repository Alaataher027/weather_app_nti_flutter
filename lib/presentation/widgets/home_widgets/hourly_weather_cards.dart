import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_nti/core/errors/failures.dart';
import 'package:weather_app_nti/core/theme/colors.dart';
import 'package:weather_app_nti/data/models/forecast_model/hourly_weather_model.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';
import 'package:weather_app_nti/helper/functions/icons_functions.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/current_location_provider.dart';
import 'package:weather_app_nti/presentation/providers/weather_providers/hourly_weather_provider.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/selected_location_provider.dart';
import 'package:weather_app_nti/presentation/widgets/custom_error_widget.dart';
import 'package:weather_app_nti/presentation/widgets/custom_loading.dart';

class HourlyWeatherCards extends ConsumerWidget {
  const HourlyWeatherCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocation = ref.watch(selectedLocationProvider);
    final currentLocation = ref.watch(currentLocationProvider);

    if (selectedLocation != null) {
      final selectedWeather = ref.watch(
        hourlyWeatherProvider(selectedLocation),
      );
      return selectedWeather.when(
        data: (either) {
          return hourlyWeatherDetails(either);
        },
        error: (error, stackTrace) {
          return CustomErrorWidget(errorMessage: error.toString());
        },
        loading:
            () => const Center(child: CustomLoading(width: 100, height: 100)),
      );
    }

    return currentLocation.when(
      data: (location) {
        final hourlyProvider = ref.watch(hourlyWeatherProvider(location));
        return hourlyProvider.when(
          data: (either) {
            return hourlyWeatherDetails(either);
          },
          error: (error, stackTrace) {
            return CustomErrorWidget(errorMessage: error.toString());
          },
          loading:
              () => const Center(child: CustomLoading(width: 100, height: 100)),
        );
      },
      loading:
          () => const Center(child: CustomLoading(width: 100, height: 100)),

      error: (error, stackTrace) {
        return CustomErrorWidget(errorMessage: error.toString());
      },
    );
  }

  Widget hourlyWeatherDetails(
    Either<Failures, List<HourlyWeatherModel>> either,
  ) {
    return either.fold(
      (failure) {
        return CustomErrorWidget(errorMessage: failure.errMessage.toString());
      },
      (data) {
        return SizedBox(
          height: 130.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                color:
                    isDark(context)
                        ? const Color.fromARGB(39, 255, 255, 255)
                        : const Color.fromARGB(60, 58, 84, 116),
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data[index].time.split(' ')[1],
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: myWhite,
                        ),
                      ),
                      const SizedBox(height: 2),
                      SvgPicture.asset(
                        getHourlyWeatherIcon(data[index].weatherCondition),
                        width: 50.h,
                        height: 50.h,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        "${data[index].tempC.toInt()}°C",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: myWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

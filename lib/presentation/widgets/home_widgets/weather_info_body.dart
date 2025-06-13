import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_nti/core/theme/colors.dart';
import 'package:weather_app_nti/data/models/forecast_model/weather_model.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';
import 'package:weather_app_nti/helper/functions/icons_functions.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/current_location_provider.dart';
import 'package:weather_app_nti/presentation/providers/weather_providers/weather_forecast_provider.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/selected_location_provider.dart';
import 'package:weather_app_nti/presentation/widgets/custom_error_widget.dart';
import 'package:weather_app_nti/presentation/widgets/custom_loading.dart';
import 'package:weather_app_nti/presentation/widgets/home_widgets/details_widget.dart';
import 'package:weather_app_nti/presentation/widgets/home_widgets/hourly_weather_cards.dart';
import 'package:weather_app_nti/presentation/widgets/home_widgets/next_days_weather.dart';

class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDark(context)
                  ? [
                    const Color(0xFF1A3B5A),
                    const Color.fromARGB(255, 55, 91, 126),
                  ]
                  : [
                    const Color.fromARGB(255, 128, 194, 247),
                    const Color.fromARGB(255, 196, 221, 255),
                  ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Consumer(
          builder: (context, ref, child) {
            final selectedLocation = ref.watch(
              selectedLocationProvider,
            ); // state provider
            final currentLocation = ref.watch(
              currentLocationProvider,
            ); // future provider

            if (selectedLocation != null) {
              final selectedWeather = ref.watch(
                weatherForecastProvider(selectedLocation),
              );

              return selectedWeather.when(
                data: (either) {
                  return either.fold(
                    (failure) {
                      print(failure.errMessage);
                      return Center(
                        child: CustomErrorWidget(
                          errorMessage: failure.errMessage,
                        ),
                      );
                    },
                    (forecastModel) {
                      final int temp = forecastModel.temp.toInt();
                      final String condition = forecastModel.weatherCondition;
                      return weatherDetails(forecastModel, temp, condition);
                    },
                  );
                },
                loading:
                    () => const Center(
                      child:  CustomLoading(width: 250, height: 250),
                    ),
                error:
                    (error, stackTrace) => Center(
                      child: CustomErrorWidget(errorMessage: error.toString()),
                    ),
              );
            } else {
              return currentLocation.when(
                data: (location) {
                  final currentProvider = ref.watch(
                    weatherForecastProvider(location),
                  );

                  return currentProvider.when(
                    data: (either) {
                      return either.fold(
                        (failure) {
                          print(failure.errMessage);
                          return Center(
                            child: Center(
                              child: CustomErrorWidget(
                                errorMessage: failure.errMessage,
                              ),
                            ),
                          );
                        },
                        (forecastModel) {
                          final int temp = forecastModel.temp.toInt();
                          final String condition =
                              forecastModel.weatherCondition;
                          return weatherDetails(forecastModel, temp, condition);
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
                        child: CustomErrorWidget(
                          errorMessage: error.toString(),
                        ),
                      );
                    },
                  );
                },
                loading:
                    () => const Center(
                      child: CustomLoading(width: 250, height: 250),
                    ),
                error:
                    (error, stackTrace) => Center(
                      child: CustomErrorWidget(errorMessage: error.toString()),
                    ),
              );
            }
          },
        ),
      ),
    );
  }

  CustomScrollView weatherDetails(
    WeatherModel forecastModel,
    int temp,
    String condition,
  ) {
    return  CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Text(
                "${forecastModel.countaryName}, ${forecastModel.cityName}",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: 25.sp,
                  color: myWhite,
                ),
              ),
              Text(
                'Last update: ${forecastModel.date.day}/${forecastModel.date.month}/${forecastModel.date.year}, ${forecastModel.date.hour}:${forecastModel.date.minute}',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: myWhite,
                ),
              ),
              SizedBox(height: 30.h),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "$temp°C",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        fontSize: 80.sp,
                        color: myWhite,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      right: 0,
                      left: 100,
                    ),
                    child: SvgPicture.asset(
                      getWeatherIcon(condition, forecastModel.isDay),
                      width: 230,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              Text(
                condition,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: 26.sp,
                  color: myWhite,
                ),
              ),
              SizedBox(height: 30.h),
              const DetailsWidget(),
              SizedBox(height: 10.h),
              const HourlyWeatherCards(),
              SizedBox(height: 10.h),
              const NextDaysWeather(),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ],
    );
  }
}

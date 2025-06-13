// ignore_for_file: unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_nti/core/theme/colors.dart';
import 'package:weather_app_nti/helper/functions/theme_function.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/current_location_provider.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/selected_location_provider.dart';
import 'package:weather_app_nti/presentation/providers/themeModeProvder.dart';
import 'package:weather_app_nti/presentation/providers/weather_providers/hourly_weather_provider.dart';
import 'package:weather_app_nti/presentation/providers/weather_providers/next_days_weather_provider.dart';
import 'package:weather_app_nti/presentation/providers/weather_providers/weather_forecast_provider.dart';
import 'package:weather_app_nti/presentation/views/search_view.dart';
import 'package:weather_app_nti/presentation/widgets/home_widgets/weather_info_body.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final brightness = MediaQuery.of(context).platformBrightness;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              isDark(context)
                  ? const Color(0xFF1A3B5A)
                  : const Color.fromARGB(255, 128, 194, 247),

          title: Consumer(
            builder: (context, ref, child) {
              final selectedLocation = ref.watch(selectedLocationProvider);
              final currentLocation = ref.watch(currentLocationProvider);
              if (selectedLocation != null) {
                final selectedWeather = ref.watch(
                  weatherForecastProvider(selectedLocation),
                );
                return selectedWeather.when(
                  data: (either) {
                    return either.fold(
                      (failure) {
                        return const Text("");
                      },
                      (data) {
                        return Text(
                          data.cityName,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: myWhite,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (error, stackTrace) => const Text(""),
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
                            return const Text("");
                          },
                          (data) {
                            return Text(
                              data.cityName,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: myWhite,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        );
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (error, stackTrace) => const Text(""),
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (error, stackTrace) => const Text(""),
                );
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final location = await ref.refresh(
                  currentLocationProvider.future,
                );

                ref.refresh(weatherForecastProvider(location));
                ref.refresh(hourlyWeatherProvider(location));
                ref.refresh(nextDaysWeatherPeovider(location));

                ref.read(selectedLocationProvider.notifier).state = location;
              },
              icon: const Icon(Icons.location_pin),
              color: myWhite,
            ),

            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (BuildContext context) {
                      return const SearchView();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.search),
              color: myWhite,
            ),

            IconButton(
              onPressed: () {
                final current = ref.read(themeModeProvider);

                if (current == ThemeMode.system) {
                  ref.read(themeModeProvider.notifier).state =
                      brightness == Brightness.dark
                          ? ThemeMode.light
                          : ThemeMode.dark;
                } else {
                  ref.read(themeModeProvider.notifier).state =
                      current == ThemeMode.dark
                          ? ThemeMode.light
                          : ThemeMode.dark;
                }
              },
              icon: Icon(
                themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: myWhite,
              ),
            ),
          ],
        ),
        body: const WeatherInfoBody(),
      ),
    );
  }
}

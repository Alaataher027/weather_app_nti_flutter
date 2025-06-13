import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_nti/presentation/providers/search_providers/search_city_provider.dart';
import 'package:weather_app_nti/presentation/providers/search_providers/searched_city_name_provider.dart';
import 'package:weather_app_nti/presentation/providers/location_providers/selected_location_provider.dart';
import 'package:weather_app_nti/presentation/widgets/custom_error_widget.dart';
import 'package:weather_app_nti/presentation/widgets/custom_loading.dart';
import 'package:weather_app_nti/presentation/widgets/search_widgets/custom_text_field.dart';
import 'package:weather_app_nti/presentation/widgets/search_widgets/search_result_item.dart';

class SearchBody extends ConsumerWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hint: 'Search..',
              onSubmitted: (citySearched) {
                ref.read(searchedCityNameProvider.notifier).state =
                    citySearched;
              },
            ),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, child) {
                final cityName = ref.watch(searchedCityNameProvider);
                if (cityName.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 150.h),

                      Center(
                        child: SvgPicture.asset(
                          "assets/images/map.svg",
                          width: 150.w,
                          height: 150.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  );
                }

                final searchProvider = ref.watch(searchCityProvider(cityName));

                return searchProvider.when(
                  data: (either) {
                    return either.fold(
                      (failure) {
                        print(failure.errMessage);
                        return CustomErrorWidget(
                          errorMessage: failure.errMessage.toString(),
                        );
                      },
                      (data) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                ref
                                    .read(selectedLocationProvider.notifier)
                                    .state = (
                                  lat: data[index].lat ?? 0,
                                  lon: data[index].lon ?? 0,
                                );
                                Navigator.pop(context);
                              },
                              child: SearchResultItem(
                                cityName: data[index].name ?? "",
                                countryName: data[index].country ?? "",
                              ),
                            );
                          },
                          separatorBuilder:
                              (context, index) => SizedBox(
                                height: MediaQuery.of(context).size.height / 60,
                              ),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}

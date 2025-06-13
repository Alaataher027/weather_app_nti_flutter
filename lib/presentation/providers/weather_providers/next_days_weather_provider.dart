import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_nti/core/dependency_injection_providers/weather_repo_provider.dart';

final nextDaysWeatherPeovider = FutureProvider.family.autoDispose((
  ref,
  ({double lat, double lon}) location, 
) {
  final service = ref.read(weatherRepoProvider);
  return service.fetchNextDaysWeather(lat: location.lat, lon: location.lon);
});

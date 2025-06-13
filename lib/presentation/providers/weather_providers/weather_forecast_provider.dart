import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_nti/core/dependency_injection_providers/weather_repo_provider.dart';

final weatherForecastProvider = FutureProvider.family.autoDispose((
  ref,
  ({double lat, double lon}) location, // record
) {
  final repoWeather = ref.read(weatherRepoProvider);
  return repoWeather.fetchCurrentWeather(lat: location.lat, lon: location.lon);
});

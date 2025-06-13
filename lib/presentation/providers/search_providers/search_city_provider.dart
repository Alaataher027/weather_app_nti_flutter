import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_nti/core/dependency_injection_providers/weather_repo_provider.dart';

final searchCityProvider = FutureProvider.family((ref, String cityName) async {
  final service = ref.read(weatherRepoProvider);
  return service.fetchSearchResults(cityName: cityName);
});

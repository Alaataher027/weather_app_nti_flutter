import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_nti/core/dependency_injection_providers/api_client_provider.dart';
import 'package:weather_app_nti/data/repo/weather_repo_imp.dart';

final weatherRepoProvider = Provider<WeatherRepoImp>((ref) {
  return WeatherRepoImp(ref.watch(apiClientProvider));
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_nti/core/api/api_client.dart';
import 'package:weather_app_nti/core/dependency_injection_providers/dio_provider.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioProvider));
});

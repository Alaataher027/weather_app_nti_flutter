import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedLocationProvider = StateProvider<({double lat, double lon})?>(
  (ref) => null,
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final currentLocationProvider = FutureProvider((ref) async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception("Location service is disabled");
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception("Location permission denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception("Location permission denied forever");
  }

  final pos = await Geolocator.getCurrentPosition();
  return (lat: pos.latitude, lon: pos.longitude);
});

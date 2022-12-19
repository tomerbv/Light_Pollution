import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static final GeolocatorPlatform _geolocatorPlatform =
      GeolocatorPlatform.instance;

  static Future<Position?> getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return null;
    }

    final position = _geolocatorPlatform.getCurrentPosition();
    return position;
  }

  static Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
      if (permission == LocationPermission.deniedForever) {
        return false;
      }
    }
    return true;
  }
}

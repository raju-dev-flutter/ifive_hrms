import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPrefs {
  late bool serviceEnabled;

  Future<void> askLocationPermission() async {
    if (await Permission.location.request().isDenied) {
      await Permission.location.status;
    }
  }

  Future<String> getCurrentAddress() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> place = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    return '${place[0].subLocality},${place[0].locality}';
  }

  Future<Placemark> getCurrentPosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> place = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    return place[0];
  }
}

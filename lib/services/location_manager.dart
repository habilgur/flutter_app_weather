import 'package:geolocator/geolocator.dart';

class GeoLocationManager {
  double latitude;
  double longitude;

  Future getLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      longitude = position.longitude;
      latitude = position.latitude;

      print(position);
    } catch (e) {
      print(e);
    }
  }
}

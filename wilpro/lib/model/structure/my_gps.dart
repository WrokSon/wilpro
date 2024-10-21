import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MyGps {
  static final instance = MyGps._();
  MyGps._();
  LatLng location = const LatLng(48.866667, 2.333333);

  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifier si le service de localisation est activé
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return location;
    }

    // Vérifier les permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return location;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return location;
    }

    // Récupérer la position actuelle
    Position position = await Geolocator.getCurrentPosition();
    location = LatLng(position.latitude, position.longitude);
    return location;
  }
}

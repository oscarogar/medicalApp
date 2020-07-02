import 'package:geolocator/geolocator.dart';

class GeoLocationService {
  final Geolocator geoLocator = Geolocator();

  Future<Position> initialPosition() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}

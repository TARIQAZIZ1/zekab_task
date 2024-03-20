import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
class GetCurrentLocation{
  static Location location = Location();
  static String name = '';
  static late bool serviceEnabled;
  static late PermissionStatus _permissionGranted;
  static late LocationData locationData;

  static Future<dynamic> getLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();
    getLocationName();
    return locationData;
  }

  static Future<void> getLocationName() async {
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          locationData.latitude!, locationData.longitude!);
      if (placemarks != null && placemarks.isNotEmpty) {
        geo.Placemark placemark = placemarks[0];
        name = placemark.administrativeArea!;
      }
    } catch (e) {

    }
  }
}
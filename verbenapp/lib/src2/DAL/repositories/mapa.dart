import 'package:verbenapp/src2/DAL/repositories/repositories.dart';

class MapaRepository {
  final Location myLocation = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  Future<LocationData> getLocation() async {
    return myLocation.getLocation();
  }

  Future<bool> setPermissions() async {
    _permissionGranted = await myLocation.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await myLocation.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> enableService() async {
    _serviceEnabled = await myLocation.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await myLocation.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    return true;
  }
}

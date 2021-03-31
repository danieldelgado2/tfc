import 'package:verbenapp/src2/BL/repositories/repositories.dart';

class MapaBL {
  final _mapaRepository = MapaRepository();

  Future<LocationData> getLocation() async {
    var permissions = await _mapaRepository.setPermissions();
    var service = await _mapaRepository.enableService();
    if (permissions && service)
      return _mapaRepository.getLocation();
    else
      return null;
  }
}

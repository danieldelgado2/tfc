import 'package:Verbenapp/src/BL/bl.dart';

///
/// Usada por los Blocs para hacer operaciones relacionadas
/// con el CRUD
///
class MapaBL {
  final _mapaRepository = MapaRepository();

  Future<LocationData> getLocation() async {
    final permissions = await _mapaRepository.setPermissions();
    final service = await _mapaRepository.enableService();
    if (permissions && service)
      return _mapaRepository.getLocation();
    else
      return null;
  }
}

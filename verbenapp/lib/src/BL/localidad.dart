import 'package:Verbenapp/src/BL/bl.dart';

///
/// Usada por los Blocs para hacer operaciones relacionadas
/// con el CRUD
///
class LocalidadBL {
  final _localidadRepository = LocalidadRepository();
  final _coordenadaRepository = CoordenadaRepository();

  Future<List<Localidad>> fromUbicacion(
      double latitude, double longitude) async {
    var nombreLocalidadesCercanas = await _coordenadaRepository
        .nombresLocFromUbicacion(latitude, longitude);
    if (nombreLocalidadesCercanas.isEmpty) return [];
    return await _localidadRepository.fromLocsName(nombreLocalidadesCercanas);
  }

  Future<List<Localidad>> fromProvName(String provincia) async =>
      await _localidadRepository.fromProvName(provincia);

  Future<List<Localidad>> delMesPorNombreProvincia(String provincia) async =>
      await _localidadRepository.delMesPorNombreProvincia(provincia);

  Future<List<Localidad>> delMesPorUbicacion(double lat, double lng) async =>
      _localidadRepository.delMes().then((localidades) => localidades
          .where((loc) =>
              Coordenada.fromJson({
                "localidad": loc.nombre,
                "latitud": loc.latitud,
                "longitud": loc.longitud
              }, lat, lng) !=
              null)
          .toList());

  Future<List<Localidad>> localidadesDD() async =>
      await _localidadRepository.localidadesDD();
  Future<List<Localidad>> delMes() async => await _localidadRepository.delMes();

  Future<bool> insertarLocalidad(Localidad loc) async {
    await _localidadRepository.insertarLocalidad(loc);
    await _coordenadaRepository.insertarCoordenada(Coordenada(
        localidad: loc.nombre, latitud: loc.latitud, longitud: loc.longitud));

    return true;
  }

  // Future<List<String>> aa() async {
  //   return _coordenadaRepository.aa();
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verbenapp/src2/BL/repositories/repositories.dart';

class LocalidadBL {
  final _localidadRepository = LocalidadRepository();
  final _coordenadaRepository = CoordenadaRepository();

  Future<List<Localidad>> fromUbicacion(
      double latitude, double longitude) async {
    var nombreLocalidadesCercanas = await _coordenadaRepository
        .nombresLocFromUbicacion(latitude, longitude);
    if (nombreLocalidadesCercanas.isEmpty) return [];
    return await _localidadRepository.fromList(nombreLocalidadesCercanas);
  }

  Future<List<Localidad>> fromProvincia(String provincia) async =>
      await _localidadRepository.fromProvincia(provincia);

  Future<List<Localidad>> fromHotProvincia(String provincia) async =>
      _localidadesEnRangoFecha(
          await _localidadRepository.fromProvincia(provincia));
  Future<List<Localidad>> fromHotUbicacion(double lat, double lng) async =>
      _localidadesEnRangoFecha(await fromUbicacion(lat, lng));
  Future<List<Localidad>> localidadesDD() async =>
      await _localidadRepository.localidadesDD();

  // Future<List<Localidad>> insertarLocalidadesProximas() async {
  //   var response =
  //       await Firestore.instance.collection('localidades').getDocuments();

  //   var localidades = Localidades.fromJsonList(
  //           response.documents.map((element) => element.data).toList())
  //       .localidades;
  //   List<Localidad> results = _localidadesEnRangoFecha(localidades);

  //   Firestore.instance
  //       .document('proximas/localidades')
  //       .setData({"lista": Localidades.toJson(results).localidadesJson});
  //   return results;
  // }

  List<Localidad> _localidadesEnRangoFecha(List<Localidad> localidades) {
    List<Localidad> results = [];
    var nextMonth = DateTime.now().add(Duration(days: 30));
    localidades.forEach((l) {
      List<Verbena> verbenasResult = [];

      l.verbenas.forEach((v) {
        var fechaDesdeParse = DateFormat('dd/MM/yyyy').parse(v.desde);
        var isBefore = fechaDesdeParse.isBefore(nextMonth);
        if (isBefore) verbenasResult.add(v);
      });
      if (verbenasResult.isNotEmpty) {
        l.verbenas = verbenasResult;
        results.add(l);
      }
    });
    return results;
  }

  // Future<bool> insertarLocalidad(Localidad loc) async {
  //   return true;
  // }

  // Future<List<Localidad>> localidadesParaSelect() async {
  //   var response =
  //       await Firestore.instance.collection('localidades').getDocuments();

  //   return Localidades.fromJsonList(
  //           response.documents.map((element) => element.data).toList())
  //       .localidades;
  // }
}

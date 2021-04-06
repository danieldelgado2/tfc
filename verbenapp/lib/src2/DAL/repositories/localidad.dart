import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verbenapp/src2/DAL/repositories/repositories.dart';

class LocalidadRepository {
  var provinciasJson = [];
  List<Localidad> proximas = [];

  Future<List<Localidad>> fromList(List<String> localidades) async {
    var request = await Firestore.instance
        .collection('localidades')
        .where('nombre', arrayContainsAny: localidades)
        .getDocuments();

    return Localidades.fromJsonList(
            request.documents.map((element) => element.data).toList())
        .localidades;
  }

  Future<List<Localidad>> fromProvincia(String nombre) async {
    var response = await Firestore.instance
        .collection('localidades')
        .where('provincia', isEqualTo: nombre)
        .getDocuments();

    return Localidades.fromJsonList(
            response.documents.map((element) => element.data).toList())
        .localidades;
  }

  Future<List<Localidad>> fromHotProvincia(String provincia) async =>
      _enRangoFecha(await fromProvincia(provincia));

  Future<List<Localidad>> localidadesDD() async {
    var response =
        await Firestore.instance.collection('localidades').getDocuments();

    return Localidades.fromJsonList(
            response.documents.map((element) => element.data).toList())
        .localidades;
  }

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

  List<Localidad> _enRangoFecha(List<Localidad> localidades) {
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

  Future<bool> insertarLocalidad(Localidad loc) async {
    await Future.delayed(Duration(seconds: 2));
    print(loc.nombre);
    print(loc.provincia);
    print(loc.latitud);
    print(loc.longitud);

    return true;
  }

  // Future<List<Localidad>> localidadesParaSelect() async {
  //   var response =
  //       await Firestore.instance.collection('localidades').getDocuments();

  //   return Localidades.fromJsonList(
  //           response.documents.map((element) => element.data).toList())
  //       .localidades;
  // }
}

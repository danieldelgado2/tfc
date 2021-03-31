import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:verbenapp/src/models/localidad.dart';
import 'package:verbenapp/src/models/provincia.dart';
import 'package:verbenapp/src/models/verbena.dart';

class LocalidadProvider {
  var provinciasJson = [];
  List<Localidad> proximas = [];

  Future<List<Localidad>> localidadesFromUbicacion(LatLng ubi) async {
    var request =
        await Firestore.instance.collection('coordenadas').getDocuments();

    var jsonList = request.documents.map((c) => c.data).toList();
    var localidadesCercanas = [];

    jsonList.forEach((element) {
      double latitud = element['latitud'];
      double long = element['longitud'];
      double distancia =
          Point(latitud, long).distanceTo(Point(ubi.latitude, ubi.longitude));
      if (distancia <= 1) localidadesCercanas.add(element['localidad']);
    });

    if (localidadesCercanas.isEmpty) return [];

    request = await Firestore.instance
        .collection('localidades')
        .where('nombre', arrayContainsAny: localidadesCercanas)
        .getDocuments();

    return Localidades.fromJsonList(
            request.documents.map((element) => element.data).toList())
        .localidades;
  }

  Future<List<Localidad>> localidadesFromProvincia(Provincia provincia) async {
    var response = await Firestore.instance
        .collection('localidades')
        .where('provincia', isEqualTo: provincia.nombre)
        .getDocuments();

    return Localidades.fromJsonList(
            response.documents.map((element) => element.data).toList())
        .localidades;
  }

  Future<List<Localidad>> localidadesCelebrandoseFromProvincia(
          Provincia provincia) async =>
      _localidadesEnRangoFecha(await localidadesFromProvincia(provincia));

  Future<List<Localidad>> localidadesCelebrandoseFromUbicacion(
          LatLng ubi) async =>
      _localidadesEnRangoFecha(await localidadesFromUbicacion(ubi));

  void localidadesConVerbenasProximas() async {
    var response =
        await Firestore.instance.document('proximas/localidades').get();
  }

  Future<List<Localidad>> insertarLocalidadesProximas() async {
    var response =
        await Firestore.instance.collection('localidades').getDocuments();

    var localidades = Localidades.fromJsonList(
            response.documents.map((element) => element.data).toList())
        .localidades;
    List<Localidad> results = _localidadesEnRangoFecha(localidades);

    Firestore.instance
        .document('proximas/localidades')
        .setData({"lista": Localidades.toJson(results).localidadesJson});
    return results;
  }

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

  Future<bool> insertarLocalidad(Localidad loc) async {
    return true;
  }

  Future<List<Localidad>> localidadesParaSelect() async {
    var response =
        await Firestore.instance.collection('localidades').getDocuments();

    return Localidades.fromJsonList(
            response.documents.map((element) => element.data).toList())
        .localidades;
  }
}

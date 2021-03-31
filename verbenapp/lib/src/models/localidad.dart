import 'dart:convert';

import 'package:latlong/latlong.dart';
import 'package:verbenapp/src/models/verbena.dart';

class Localidades {
  List<Localidad> localidades = [];
  List<Map<String, dynamic>> localidadesJson = [];

  Localidades();

  Localidades.fromJsonList(List<Map<String, dynamic>> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final localidad = new Localidad.fromJson(item);
      localidades.add(localidad);
    }
  }
  Localidades.fromJsonListSinVerbenas(List<Map<String, dynamic>> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final localidad = new Localidad.fromJsonSinVerbenas(item);
      localidades.add(localidad);
    }
  }
  Localidades.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      final localidad = Localidad.fromJson(value);
      localidad.id = key;
      localidades.add(localidad);
    });
  }
  Localidades.toJson(List<Localidad> localidades) {
    localidades.forEach((l) {
      localidadesJson.add(l.toJson());
    });
  }
}
// To parse this JSON data, do
//
//     final verbena = verbenaFromJson(jsonString);

class Localidad {
  Localidad({this.id, this.nombre, this.coord, this.provincia, this.verbenas});

  String nombre;
  String id;
  String provincia;
  LatLng coord;
  double longitud;
  List<Verbena> verbenas;

  factory Localidad.fromJson(Map<String, dynamic> json) => Localidad(
      nombre: json["nombre"],
      provincia: json['provincia'],
      coord: LatLng(json['latitud'], json['longitud']),
      verbenas: List<Verbena>.from(Verbenas.fromJsonList(
              json["verbenas"], json["nombre"], json['provincia'])
          .verbenas));
  factory Localidad.fromJsonSinVerbenas(Map<String, dynamic> json) => Localidad(
      nombre: json["nombre"],
      provincia: json['provincia'],
      coord: LatLng(json['latitud'], json['longitud']),
      verbenas: []);

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "longitud": coord.latitude,
        "latitud": coord.longitude,
        "verbenas": List<dynamic>.from(verbenas.map((x) => x.toJson()))
      };
}

Localidad localidadFromJson(String str) => Localidad.fromJson(json.decode(str));

String localidadToJson(Localidad data) => json.encode(data.toJson());

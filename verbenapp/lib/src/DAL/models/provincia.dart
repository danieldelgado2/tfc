import 'dart:convert';

import 'package:Verbenapp/src/DAL/models/localidad.dart';

///
/// Realiza operaciones de parseo para una
/// lista de Provincia
///
class Provincias {
  List<Provincia> provincias = [];

  Provincias();

  Provincias.fromJsonList(List<Map<String, dynamic>> jsonList) {
    if (jsonList.isEmpty) return;

    for (var item in jsonList) {
      final provincia = new Provincia.fromJson(item);
      provincias.add(provincia);
    }
  }
  Provincias.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      final provincia = Provincia.fromJson(value);
      provincias.add(provincia);
    });
  }
}

///
/// Modelo de la coleccion en BD con el mismo nombre.
/// Contiene una lista de Localidad que mostrará en
/// el mapa.
///
class Provincia {
  Provincia(
      {this.nombre = '',
      this.latitud = 0.0,
      this.longitud = 0.0,
      this.localidades = const <Localidad>[]});

  String nombre;
  double latitud;
  double longitud;
  List<Localidad> localidades;

  factory Provincia.fromJson(Map<String, dynamic> json) => Provincia(
      nombre: json["nombre"],
      latitud: json['latitud'],
      longitud: json['longitud'],
      localidades: <Localidad>[]);

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
      };
}

Provincia provinciaFromJson(String str) => Provincia.fromJson(json.decode(str));

String provinciaToJson(Provincia data) => json.encode(data.toJson());

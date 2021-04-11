import 'dart:convert';

import 'package:verbenapp/src/DAL/models/localidad.dart';

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
// To parse this JSON data, do
//
//     final verbena = verbenaFromJson(jsonString);

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

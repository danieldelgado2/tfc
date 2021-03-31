import 'dart:convert';

import 'package:latlong/latlong.dart';

class Provincias {
  List<Provincia> provincias = [];

  Provincias();

  Provincias.fromJsonList(List<Map<String, dynamic>> jsonList) {
    if (jsonList == null) return;

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
  Provincia({this.nombre, this.coord});

  String nombre;
  LatLng coord;

  factory Provincia.fromJson(Map<String, dynamic> json) => Provincia(
      nombre: json["nombre"], coord: LatLng(json['latitud'], json['longitud']));

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
      };
}

Provincia provinciaFromJson(String str) => Provincia.fromJson(json.decode(str));

String provinciaToJson(Provincia data) => json.encode(data.toJson());

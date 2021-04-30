import 'dart:convert';

import 'dart:math';

///
/// Realiza operaciones de parseo para una
/// lista de Coordenada
///
class Coordenadas {
  List<Coordenada> coordenadas = [];

  Coordenadas();

  Coordenadas.fromJsonList(
      List<Map<String, dynamic>> jsonList, double lat, double lng) {
    if (jsonList.isEmpty) return;

    for (var item in jsonList) {
      final coordenada = new Coordenada.fromJson(item, lat, lng);
      coordenadas.add(coordenada);
    }
  }

  Coordenadas.fromJson(Map<String, dynamic> json, double lat, double lng) {
    json.forEach((key, value) {
      final coordenada = Coordenada.fromJson(value, lat, lng);
      coordenadas.add(coordenada);
    });
  }
}

///
/// Modelo de la coleccion en BD con el mismo nombre.
/// Se encarga de parsear solo los registros de BD que
/// esten dentro de un rango determinado.
///
class Coordenada {
  Coordenada({this.localidad = '', this.latitud = 0.0, this.longitud = 0.0});

  String localidad;
  double latitud;
  double longitud;

  factory Coordenada.fromJson(
          Map<String, dynamic> json, double lat, double lng) =>
      (Point(lat, lng).distanceTo(Point(json['latitud'], json['longitud'])) <=
              0.8)
          ? Coordenada(
              localidad: json["localidad"],
              latitud: json['latitud'],
              longitud: json['longitud'])
          : null;

  Map<String, dynamic> toJson() => {
        "localidad": localidad,
        "latitud": latitud,
        "longitud": longitud,
      };
}

String coordenadaToJson(Coordenada data) => json.encode(data.toJson());

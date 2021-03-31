import 'dart:convert';

class Coordenadas {
  List<Coordenada> coordenadas = [];

  Coordenadas();

  Coordenadas.fromJsonList(List<Map<String, dynamic>> jsonList) {
    if (jsonList.isEmpty) return;

    for (var item in jsonList) {
      final coordenada = new Coordenada.fromJson(item);
      coordenadas.add(coordenada);
    }
  }
  Coordenadas.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      final coordenada = Coordenada.fromJson(value);
      coordenadas.add(coordenada);
    });
  }
}
// To parse this JSON data, do
//
//     final verbena = verbenaFromJson(jsonString);

class Coordenada {
  Coordenada({this.localidad = '', this.latitud = 0.0, this.longitud = 0.0});

  String localidad;
  double latitud;
  double longitud;

  factory Coordenada.fromJson(Map<String, dynamic> json) => Coordenada(
      localidad: json["localidad"],
      latitud: json['latitud'],
      longitud: json['longitud']);

  Map<String, dynamic> toJson() => {
        "localidad": localidad,
      };
}

Coordenada coordenadaFromJson(String str) =>
    Coordenada.fromJson(json.decode(str));

String coordenadaToJson(Coordenada data) => json.encode(data.toJson());

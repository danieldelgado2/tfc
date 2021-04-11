import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:verbenapp/src/DAL/models/models.dart';

class Localidades {
  List<Localidad> localidades = [];
  List<Map<String, dynamic>> localidadesJson = [];

  Localidades();

  Localidades.fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return;

    for (var item in jsonList) {
      final localidad = new Localidad.fromJson(item);

      localidades.add(localidad);
    }
  }
  Localidades.fromDocumentsList(List<DocumentSnapshot> documents) {
    if (documents.isEmpty) return;

    for (var item in documents) {
      final localidad = new Localidad.fromJson(item.data);
      localidad.id = item.reference.documentID;
      localidades.add(localidad);
    }
  }
  Localidades.fromDocumentsListToProximas(List<DocumentSnapshot> documents) {
    if (documents.isEmpty) return;

    for (var item in documents) {
      final localidad = new Localidad.fromJsonToProximas(item.data);

      localidad.id = item.reference.documentID;
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
  Localidad(
      {this.id = '',
      this.nombre = '',
      this.latitud = 0.0,
      this.longitud = 0.0,
      this.provincia = '',
      this.verbenas = const <Verbena>[]});

  String nombre;
  String id;
  String provincia;
  double longitud;
  double latitud;
  List<Verbena> verbenas;
  Marker marcador;

  factory Localidad.fromJson(dynamic json) => Localidad(
      nombre: json["nombre"],
      provincia: json['provincia'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      verbenas: List<Verbena>.from(Verbenas.fromJsonList(
              json["verbenas"], json["nombre"], json['provincia'])
          .verbenas));
  factory Localidad.fromJsonToProximas(Map<String, dynamic> json) => Localidad(
      nombre: json["nombre"],
      provincia: json['provincia'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      verbenas: List<Verbena>.from(Verbenas.fromJsonListToProximas(
              json["verbenas"], json["nombre"], json['provincia'])
          .verbenas));

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "longitud": latitud,
        "latitud": longitud,
        "provincia": provincia,
        "verbenas": List<dynamic>.from(verbenas.map((x) => x.toJson()))
      };
}

Localidad localidadFromJson(String str) => Localidad.fromJson(json.decode(str));

String localidadToJson(Localidad data) => json.encode(data.toJson());

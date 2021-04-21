import 'dart:convert';

import 'package:intl/intl.dart';

class Verbenas {
  List<Verbena> verbenas = [];
  List<Map<String, dynamic>> verbenasToJson = [];

  Verbenas();

  Verbenas.fromJsonList(
      List<dynamic> jsonList, String localidad, String provincia) {
    if (jsonList.isEmpty) return;

    for (var item in jsonList) {
      final verbena = new Verbena.fromJson(item);
      verbena.localidad = localidad;
      verbena.provincia = provincia;
      verbenas.add(verbena);
    }
  }
  Verbenas.fromJsonListToProximas(
      List<dynamic> jsonList, String localidad, String provincia) {
    if (jsonList.isEmpty) return;

    for (var item in jsonList) {
      var verbena;
      if ((verbena = Verbena.fromJsonToProximas(item)) != null) {
        verbena.localidad = localidad;
        verbena.provincia = provincia;
        verbenas.add(verbena);
      }
    }
  }
  Verbenas.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      final verbena = Verbena.fromJson(value);
      verbena.id = key;
      verbenas.add(verbena);
    });
  }
  Verbenas.toJson(List<Verbena> verbenas) {
    verbenas.forEach((v) => verbenasToJson.add(v.toJson()));
  }
}
// To parse this JSON data, do
//
//     final verbena = verbenaFromJson(jsonString);

class Verbena {
  Verbena(
      {this.id = '',
      this.uniqueId = '',
      this.descripcion = '',
      this.detailImg = '',
      this.hasta = '',
      this.desde = '',
      this.img = '',
      this.nombre = '',
      this.provincia = '',
      this.localidad = '',
      this.url = '',
      this.urlTrip = '',
      this.urlDoc = ''});

  String descripcion;
  String detailImg;
  String hasta;
  String desde;
  String img;
  String nombre;
  String provincia;
  String localidad;
  String id;
  String uniqueId;
  String url;
  String urlTrip;
  String urlDoc;

  factory Verbena.fromJson(Map<dynamic, dynamic> json) => Verbena(
      hasta: json['hasta'],
      descripcion: json["descripcion"],
      desde: json["desde"],
      nombre: json["nombre"],
      url: json['url'],
      img: json['img'],
      urlTrip: json['url_trip'],
      urlDoc: json['url_doc']);
  factory Verbena.fromJsonToProximas(Map<dynamic, dynamic> json) {
    var nextMonth = DateTime.now().add(Duration(days: 30));
    var fechaDesdeParse = DateFormat('dd/MM/yyyy').parse(json['desde']);
    var fechaHastaParse = DateFormat('dd/MM/yyyy').parse(json['hasta']);
    var isInRange = !(fechaDesdeParse.isBefore(DateTime.now()) &&
            fechaHastaParse.isBefore(DateTime.now())) &&
        !(fechaDesdeParse.isAfter(nextMonth) &&
            fechaHastaParse.isAfter(nextMonth));
    if (isInRange)
      return Verbena(
          hasta: json['hasta'],
          descripcion: json["descripcion"],
          desde: json["desde"],
          nombre: json["nombre"],
          url: json['url'],
          img: json['img'],
          urlTrip: json['url_trip'],
          urlDoc: json['url_doc']);
    return null;
  }

  toJson() => {
        "descripcion": descripcion,
        "hasta": hasta,
        "desde": desde,
        "nombre": nombre,
        "url": url,
        "img": img,
        "url_trip": urlTrip,
        "url_doc": "http://www.africau.edu/images/default/sample.pdf"
      };

  getImg() {
    if (img == null) {
      return 'https://miro.medium.com/max/10000/0*h7lBavOZfiphLHuX';
    } else {
      return img;
    }
  }

  getBackImg() {
    if (detailImg == null) {
      return 'https://miro.medium.com/max/10000/0*h7lBavOZfiphLHuX';
    } else {
      return detailImg;
    }
  }
}

Verbena verbenaFromJson(String str) => Verbena.fromJson(json.decode(str));

String verbenaToJson(Verbena data) => json.encode(data.toJson());

import 'dart:convert';

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
      this.url = ''});

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

  factory Verbena.fromJson(Map<dynamic, dynamic> json) => Verbena(
      hasta: json['hasta'],
      descripcion: json["descripcion"],
      desde: json["desde"],
      nombre: json["nombre"],
      url: json['url'],
      img: json['img']);

  toJson() => {
        "descripcion": descripcion,
        "hasta": hasta,
        "desde": desde,
        "nombre": nombre,
        "url": url,
        "img": img
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
      return '$detailImg';
    }
  }
}

Verbena verbenaFromJson(String str) => Verbena.fromJson(json.decode(str));

String verbenaToJson(Verbena data) => json.encode(data.toJson());

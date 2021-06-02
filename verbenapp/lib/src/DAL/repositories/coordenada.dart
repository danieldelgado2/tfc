import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Verbenapp/src/DAL/models/models.dart';
import 'package:Verbenapp/src/DAL/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///
/// Encargado de realizar operaciones CRUD en BD
///
class CoordenadaRepository {
  final _coordRepository = Firestore.instance.collection('coordenadas');
  final api_key = "pk.af3de380bab8b66d3edf82e38256c1da";

  Future<List<String>> nombresLocFromUbicacion(double lat, double lng) async {
    var results = <String>[];
    var coord;

    (await _coordRepository.getDocuments()).documents.forEach((d) {
      if ((coord = Coordenada.fromJson(d.data, lat, lng)) != null)
        results.add(coord.localidad);
    });
    return results;
  }

  Future<bool> insertarCoordenada(Coordenada coord) async {
    var resuults = await _coordRepository
        .where('localidad', isEqualTo: coord.localidad)
        .getDocuments();
    var results;
    if (resuults.documents.isEmpty) {
      results = await _coordRepository.add(coord.toJson());
    } else {
      results = _coordRepository
          .document(resuults.documents[0].documentID)
          .setData(coord.toJson());
    }

    return results != null;
  }

  // Future<List<String>> aa() async {
  //   final a = await http.get(Uri.parse(
  //       'https://us1.locationiq.com/v1/reverse.php?key=$api_key&lat=36.97536&lon=-3.190055&format=json'));
  //   final b = json.decode(a.body);
  //   final c = b['address'];
  //   return null;
  // }
}

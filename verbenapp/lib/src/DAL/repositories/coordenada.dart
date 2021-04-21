import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verbenapp/src/DAL/models/models.dart';
import 'package:verbenapp/src/DAL/repositories/repositories.dart';

class CoordenadaRepository {
  final _coordRepository = Firestore.instance.collection('coordenadas');

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
}

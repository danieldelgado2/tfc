import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verbenapp/src2/DAL/repositories/repositories.dart';

class CoordenadaRepository {
  Future<List<String>> nombresLocFromUbicacion(double lat, double lng) async {
    var request =
        await Firestore.instance.collection('coordenadas').getDocuments();

    var results = <String>[];
    Coordenadas.fromJsonList(
            request.documents.map((coord) => coord.data).toList())
        .coordenadas
        .forEach((coord) {
      if (Point(lat, lng).distanceTo(Point(coord.latitud, coord.longitud)) <= 1)
        results.add(coord.localidad);
    });
    return results;
  }
}

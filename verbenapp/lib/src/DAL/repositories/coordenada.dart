import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verbenapp/src/DAL/models/models.dart';
import 'package:verbenapp/src/DAL/repositories/repositories.dart';

class CoordenadaRepository {
  final _coordRepository = Firestore.instance.collection('coordenadas');
  Future<List<String>> nombresLocFromUbicacion(double lat, double lng) async =>
      (await _coordRepository.getDocuments())
          .documents
          .map((e) => Coordenada.fromJson(e.data, lat, lng).localidad)
          .toList();
}

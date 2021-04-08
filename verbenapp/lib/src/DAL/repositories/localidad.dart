import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verbenapp/src/DAL/models/models.dart';
import 'package:verbenapp/src/DAL/repositories/repositories.dart';

class LocalidadRepository {
  final _localidadesRepository = Firestore.instance.collection('localidades');
  final _localidadesProximasRepository =
      Firestore.instance.collection('proximas').document('localidades');

  Future<List<Localidad>> localidadesDD() async {
    var response = await _localidadesRepository.getDocuments();

    return Localidades.fromDocumentsList(response.documents).localidades;
  }

  Future<List<Localidad>> fromLocsName(List<String> localidades) async {
    var request = await _localidadesRepository
        .where('nombre', arrayContainsAny: localidades)
        .getDocuments();

    return Localidades.fromJsonList(
            request.documents.map((element) => element.data).toList())
        .localidades;
  }

  Future<List<Localidad>> fromProvincia(String nombre) async {
    var response = await _localidadesRepository
        .where('provincia', isEqualTo: nombre)
        .getDocuments();

    return Localidades.fromJsonList(
            response.documents.map((element) => element.data).toList())
        .localidades;
  }

  Future<List<Localidad>> delMes() async => Localidades.fromJson(
          (await _localidadesProximasRepository.get()).data['lista'])
      .localidades;

  Future<List<Localidad>> delMesPorNombreProvincia(String provincia) async =>
      delMes().then((localidades) =>
          localidades.where((loc) => loc.provincia == provincia).toList());

  Future<List<Localidad>> crearDelMes() async {
    final localidadesDelMes = Localidades.fromDocumentsListToProximas(
            (await _localidadesRepository.getDocuments()).documents)
        .localidades;
    _localidadesProximasRepository
        .setData({"lista": Localidades.toJson(localidadesDelMes)});
    return localidadesDelMes;
  }

  Future<bool> insertarLocalidad(Localidad loc) async {
    if (loc.id != "") {
      await _localidadesRepository.document(loc.id).setData(loc.toJson());
      return true;
    }

    return (await _localidadesRepository.add(loc.toJson()) != null);
  }
}

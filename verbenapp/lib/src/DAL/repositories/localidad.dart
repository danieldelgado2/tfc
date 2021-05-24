import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Verbenapp/src/DAL/models/models.dart';
import 'package:Verbenapp/src/DAL/repositories/repositories.dart';

///
/// Encargado de realizar operaciones CRUD en BD
///
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
        .where('nombre', whereIn: localidades)
        .getDocuments();

    return Localidades.fromJsonList(
            request.documents.map((element) => element.data).toList())
        .localidades;
  }

  Future<List<Localidad>> fromProvName(String nombre) async {
    var response = await _localidadesRepository
        .where('provincia', isEqualTo: nombre)
        .getDocuments();

    return Localidades.fromJsonList(
            response.documents.map((element) => element.data).toList())
        .localidades;
  }

  Future<List<Localidad>> delMes() async => Localidades.fromJsonList(
          (await _localidadesProximasRepository.get()).data['lista'])
      .localidades;

  Future<List<Localidad>> delMesPorNombreProvincia(String provincia) async =>
      delMes().then((localidades) =>
          localidades.where((loc) => loc.provincia == provincia).toList());

  Future<List<Localidad>> crearDelMes() async {
    final localidadesDelMes = Localidades.fromDocumentsListToProximas(
            (await _localidadesRepository.getDocuments()).documents)
        .localidades;
    _localidadesProximasRepository.setData(
        {"lista": Localidades.toJson(localidadesDelMes).localidadesJson});
    return localidadesDelMes;
  }

  Future<bool> insertarLocalidad(Localidad loc) async {
    var result;
    if (loc.id != "") {
      result = _localidadesRepository.document(loc.id).setData(loc.toJson());
      return true;
    } else {
      result = await _localidadesRepository.add(loc.toJson());
    }
    crearDelMes();
    return (result != null);
  }
}

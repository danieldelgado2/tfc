import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verbenapp/src/DAL/models/models.dart';

///
/// Encargado de realizar operaciones CRUD en BD
///
class ProvinciaRepository {
  Future<List<Provincia>> provinciasParaSelect() async {
    var response =
        await Firestore.instance.collection('provincias').getDocuments();

    return Provincias.fromJsonList(
            response.documents.map((element) => element.data).toList())
        .provincias;
  }
}

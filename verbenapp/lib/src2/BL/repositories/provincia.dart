// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verbenapp/src2/BL/repositories/repositories.dart';

class ProvinciaBL {
  final _provinciaRepository = ProvinciaRepository();
  var provinciasJson = [];

  Future<List<Provincia>> provinciasParaSelect() async {
    return await _provinciaRepository.provinciasParaSelect();
  }
}

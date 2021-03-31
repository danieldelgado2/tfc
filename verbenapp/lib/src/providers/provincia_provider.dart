import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verbenapp/src/models/provincia.dart';

class ProvinciaProvider {
  var provinciasJson = [];

  Future<List<Provincia>> provinciasParaSelect() async {
    var response =
        await Firestore.instance.collection('provincias').getDocuments();

    return Provincias.fromJsonList(
            response.documents.map((element) => element.data).toList())
        .provincias;
  }
}

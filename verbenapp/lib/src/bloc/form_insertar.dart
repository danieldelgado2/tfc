import 'dart:async';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';
import 'package:verbenapp/src/models/localidad.dart';
import 'package:verbenapp/src/providers/localidad_provider.dart';

class FormularioInsertarBloc {
  final _localidadEditarController = BehaviorSubject<Localidad>();
  final _localidadSeleccionadaController = BehaviorSubject<Localidad>();
  final _localidadsDropdownController = BehaviorSubject<List<Localidad>>();
  final _onPressController = BehaviorSubject<void Function()>();
  final GlobalKey key = GlobalKey<FormState>();
  Localidad localidadEditar = Localidad(verbenas: []);
  String nombre;
  double latitud;
  double longitud;
  String provincia;
  String nombreVerbena;
  String descripcion;
  String url;
  String img;
  String desde;
  String hasta;

  final controllerTextSearch = TextEditingController();
  List<Localidad> localidadsFiltradasDropDownValue = [];

  final _localidadProvider = LocalidadProvider();

  Stream<Localidad> get localidadSeleccionadaStream =>
      _localidadEditarController.stream;
  Stream<Localidad> get localidadEditarStream =>
      _localidadEditarController.stream;
  Stream<List<Localidad>> get localidadsDropdownStream =>
      _localidadsDropdownController.stream;

  // Insertar valores al Stream
  Function(Localidad) get changeLocalidadEditar =>
      _localidadEditarController.sink.add;
  Function(List<Localidad>) get changeLocalidadesDropDown =>
      _localidadsDropdownController.sink.add;
  Function(Localidad) get changeLocalidadSeleccionada =>
      _localidadSeleccionadaController.sink.add;

  // Obtener el ultimo valor ingresado a los streams
  Localidad get localidad => _localidadEditarController.value;
  Localidad get localidadSeleccionada => _localidadSeleccionadaController.value;
  List<Localidad> get localidadsDropdownValue =>
      _localidadsDropdownController.value;

  void crearLocalidadesDropdown() async => _localidadsDropdownController.sink
      .add(await _localidadProvider.localidadesParaSelect());

  Future<List<Localidad>> getLocalidadesFiltradas(String filter) async {
    if (filter.isEmpty) return [];
    var results = [];
    localidadsDropdownValue.forEach((p) {
      var plw = p.nombre.toLowerCase();
      var flw = filter.toLowerCase();
      var found = plw.contains(flw);
      if (!found) return false;
      results.add(p);
    });

    return results;
  }

  dispose() {
    _localidadEditarController?.close();
    _localidadsDropdownController?.close();
    _localidadSeleccionadaController?.close();
    _onPressController?.close();
  }
}

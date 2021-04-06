import 'package:flutter/material.dart';
import 'package:verbenapp/form/form.dart';
import 'package:verbenapp/src/bloc/form_busqueda.dart';
import 'package:verbenapp/src/bloc/mapa_bloc.dart';

import 'form_insertar.dart';
import 'localidad_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  final localidadBL = LocalidadBL();
  final localidadesBloc = LocalidadesBloc();
  final FormLocalidadBloc = FormularioBloc();
  final formInsertarBloc = FormularioInsertarBloc();
  final mapaBloc = MapaBloc();

  // Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static FormularioBloc ofFormMapa(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        .FormLocalidadBloc;
  }

  static LocalidadesBloc ofLocalidades(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        .localidadesBloc;
  }

  static MapaBloc ofMapa(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().mapaBloc;
  }

  static FormularioInsertarBloc ofFormInsertar(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        .formInsertarBloc;
  }

  static LocalidadBL ofLocalidadBL(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().localidadBL;
  }
}

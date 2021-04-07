import 'package:flutter/material.dart';
import 'package:verbenapp/src/BL/bl.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  final provinciaBL = ProvinciaBL();
  final localidadBL = LocalidadBL();
  final mapaBL = MapaBL();

  // Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LocalidadBL ofLocalidadBL(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().localidadBL;
  }

  static MapaBL ofMapaBL(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().mapaBL;
  }

  static ProvinciaBL ofProvinciaBL(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().provinciaBL;
  }
}

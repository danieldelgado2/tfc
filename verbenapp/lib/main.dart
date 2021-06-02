import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Verbenapp/src/BL/bl.dart';
import 'package:Verbenapp/src/pages/buscar/buscar.dart';
import 'package:Verbenapp/src/pages/buscar/buscar_page.dart';
import 'package:Verbenapp/src/pages/detalle/detalle_page.dart';
import 'package:Verbenapp/src/pages/form/bloc.dart';
import 'package:Verbenapp/src/pages/form/form_page.dart';
import 'package:flutter/services.dart';

import 'src/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

///
/// Clase principal de la que arranca la aplicación.
/// Contiene todos los bloc que se usan a lo largo de
/// la app además de los BL para que los bloc tengan acceso.
///
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eventos',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'buscar': (BuildContext context) => BuscarPage(),
        'form': (BuildContext context) => FormPage(),
        'detalle': (BuildContext context) => DetallePage(),
      },

      // Define the default TextTheme. Use this to specify the default
      // text styling for hea),
    );
  }
}

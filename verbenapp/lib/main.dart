import 'package:flutter/material.dart';
import 'package:verbenapp/provider.dart';

import 'buscar/views/buscar_page.dart';
import 'detalle/views/detalle_page.dart';
import 'form/view/form_page.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
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
      ),
    );
  }
}

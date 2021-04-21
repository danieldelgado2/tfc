import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/src/BL/bl.dart';
import 'package:verbenapp/src/pages/buscar/bloc.dart';
import 'package:verbenapp/src/pages/buscar/buscar_page.dart';
import 'package:verbenapp/src/pages/detalle/detalle_page.dart';
import 'package:verbenapp/src/pages/form/bloc.dart';
import 'package:verbenapp/src/pages/form/form_page.dart';
import 'package:dcdg/dcdg.dart';

import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _mapaBL = MapaBL();
  final _provinciaBL = ProvinciaBL();
  final _localidadBL = LocalidadBL();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FormBusquedaBloc>(
          create: (BuildContext context) => FormBusquedaBloc(
            _localidadBL,
          ),
        ),
        BlocProvider<BannerBusquedaBloc>(
            create: (context) => BannerBusquedaBloc(mapaBL: _mapaBL)),
        BlocProvider<BannerVisibleBloc>(
          create: (BuildContext context) => BannerVisibleBloc(),
        ),
        BlocProvider<DropDownProvinciasBloc>(
          create: (BuildContext context) =>
              DropDownProvinciasBloc(provinciaBL: _provinciaBL),
        ),
        BlocProvider<LocalidadSeleccionadaBloc>(
          create: (BuildContext context) => LocalidadSeleccionadaBloc(),
        ),
        BlocProvider<DDBloc>(
          create: (BuildContext context) => DDBloc(localidadBL: _localidadBL),
        ),
        BlocProvider<FormLocalidadBloc>(
          create: (BuildContext context) =>
              FormLocalidadBloc(localidadBL: _localidadBL),
        ),
        BlocProvider<FormVerbenaBloc>(
          create: (BuildContext context) => FormVerbenaBloc(),
        ),
      ],
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

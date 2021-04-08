import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/form/form.dart';

import 'buscar/bloc/BannerBusqueda/banner_busqueda_bloc.dart';
import 'buscar/bloc/BannerVisible/banner_visible_bloc.dart';
import 'buscar/bloc/DropDownProvincias/dropDownProvincias.dart';
import 'buscar/bloc/FormBusqueda/form_busqueda_bloc.dart';
import 'buscar/bloc/LocalidadSeleccionada/localidad_seleccionada_bloc.dart';
import 'buscar/bloc/MapaBusqueda/mapa_busqueda_bloc.dart';
import 'buscar/views/buscar_page.dart';
import 'detalle/views/detalle_page.dart';
import 'form/bloc/DropDownLocalidad/dd_bloc.dart';
import 'form/bloc/FormLocalidad/form_localidad_bloc.dart';
import 'form/bloc/FormVerbena/form_verbena_bloc.dart';
import 'form/view/form_page.dart';
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
          create: (BuildContext context) =>
              FormBusquedaBloc(_localidadBL, _mapaBL),
        ),
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
        BlocProvider<BannerBusquedaBloc>(
          create: (BuildContext context) => BannerBusquedaBloc(),
        ),
        BlocProvider<MapaBusquedaBloc>(
          create: (BuildContext context) => MapaBusquedaBloc(),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/buscar/bloc/bloc.dart';
import 'package:verbenapp/provider.dart';

import 'appBar.dart';

class BuscarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _locBL = Provider.ofLocalidadBL(context);
    //final _mapaBL = Provider.ofMapaBL(context);
    final _provinciaBL = Provider.ofProvinciaBL(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocProvider(providers: [
        BlocProvider<FormBusquedaBloc>(
          create: (BuildContext context) => FormBusquedaBloc(_locBL),
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
      ], child: _BuscarPage()),
    );
  }
}

class _BuscarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return CustomScrollView(slivers: [
      SliverAppBar(
        automaticallyImplyLeading: false,
        elevation: 2.0,
        backgroundColor: Colors.indigoAccent,
        expandedHeight: _sc.height * 0.9,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: AppBarMapa(),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [ContainerVerbenas()],
        ),
      )
    ]);
  }
}

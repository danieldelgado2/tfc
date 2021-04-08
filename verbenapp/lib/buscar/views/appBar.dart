import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/buscar/bloc/bloc.dart';
import 'package:verbenapp/buscar/views/verbena_horizontal.dart';

import 'dd_provincias.dart';

class AppBarMapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Mapa(),
        BannerDinamico(
          screenSize: _sc,
        ),
        BotonBusqueda(sc: _sc)
      ],
    );
  }
}

class BannerDinamico extends StatelessWidget {
  final screenSize;

  BannerDinamico({@required this.screenSize});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerVisibleBloc, BannerVisibleState>(
      builder: (context, state) {
        return AnimatedPositioned(
          right: state.visible ? 0 : screenSize.width,
          top: screenSize.height * 0.04,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: BannerBusqueda(),
        );
      },
    );
  }
}

class BannerBusqueda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      child: BlocBuilder<BannerBusquedaBloc, BannerBusquedaState>(
        builder: (context, state) {
          final isPorProvincia =
              (state.status == BannerBusquedaStatus.porProvincia);
          void onChangeSwitch(bool value) => (isPorProvincia)
              ? context
                  .read<BannerBusquedaBloc>()
                  .add(PorProvincia(celebrandose: value))
              : context
                  .read<BannerBusquedaBloc>()
                  .add(PorUbicacion(celebrandose: value));
          return Row(
            children: [
              Container(
                width: screenSize.width * 0.68,
                height: screenSize.height * 0.22,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Switch(
                              activeColor: Colors.deepOrangeAccent,
                              value: !isPorProvincia,
                              onChanged: (value) => onChangeSwitch(!value)),
                          Switch(
                              activeColor: Colors.deepOrangeAccent,
                              value: isPorProvincia,
                              onChanged: (value) => onChangeSwitch(value)),
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                activeColor: Colors.deepOrangeAccent,
                                value: state.celebrandose,
                                onChanged: (value) {
                                  context
                                      .read<BannerBusquedaBloc>()
                                      .add(CambiaCheck(celebrandose: value));
                                }),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cerca de mí',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          Container(
                              height: screenSize.height * 0.07,
                              width: screenSize.width * 0.5,
                              child: SelectProvincias(enabled: isPorProvincia)),
                          Padding(padding: EdgeInsets.all(5)),
                          Text(
                            'Próximas',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FloatingActionButton(
                heroTag: 'button-save',
                child: Icon(
                  Icons.check,
                  size: 30,
                ),
                backgroundColor: Colors.deepOrangeAccent,
                onPressed: () => (isPorProvincia)
                    ? context.read<FormBusquedaBloc>().add(
                        BuscarPorProvincia(celebrandose: state.celebrandose))
                    : context.read<FormBusquedaBloc>().add(
                        BuscarPorUbicacion(celebrandose: state.celebrandose)),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  List<Marker> marcadores = [];

  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormBusquedaBloc, FormBusquedaState>(
      listener: (context, state) {
        if (state.status == FormBusquedaStatus.empty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
            height: 100,
            width: 400,
            color: Colors.deepOrangeAccent,
            child: Text('Oops! No hay resultados :('),
          )));
        }

        if (state.status == FormBusquedaStatus.success) {
          marcadores.clear();

          setState(() {
            _mapController.move(
                LatLng(state.provincia.latitud, state.provincia.longitud), 8);
            marcadores = state.localidades
                .map(
                  (l) => Marker(
                    point: LatLng(l.latitud, l.longitud),
                    builder: (ctx) => IconButton(
                      icon: Icon(Icons.emoji_emotions_rounded),
                      color: Colors.deepOrangeAccent,
                      onPressed: () {
                        setState(() {
                          _mapController.move(
                            LatLng(l.latitud, l.longitud),
                            14,
                          );
                        });
                        context
                            .read<LocalidadSeleccionadaBloc>()
                            .add(ChangeLoc(data: l));
                      },
                    ),
                  ),
                )
                .toList();
          });
        }
      },
      child: BlocBuilder<FormBusquedaBloc, FormBusquedaState>(
          builder: (context, state) {
        return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
              center: LatLng(36.716667, -4.416667),
              zoom: 6,
              controller: _mapController),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(markers: marcadores),
          ],
        );
      }),
    );
  }
}

class BotonBusqueda extends StatelessWidget {
  final sc;
  BotonBusqueda({this.sc});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerVisibleBloc, BannerVisibleState>(
      builder: (context, state) {
        return Positioned(
          top: sc.height * 0.108,
          right: 10,
          child: FloatingActionButton(
            heroTag: 'button-search',
            child: Icon(
              Icons.search,
              size: 30,
            ),
            backgroundColor: Colors.deepOrangeAccent,
            onPressed: () => context
                .read<BannerVisibleBloc>()
                .add(BannerVisibleEvent(!state.visible)),
          ),
        );
      },
    );
  }
}

class ContainerVerbenas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return BlocBuilder<LocalidadSeleccionadaBloc, LocalidadSeleccionadaState>(
      builder: (context, state) {
        if (state.status == LocalidadSeleccionadaStatus.initial) {
          return Center(
            child: Text('Selecciona una localidad para ver sus fiestas'),
          );
        }
        return Container(
          width: _screenSize.width,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${state.localidad.nombre}',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent),
                  ),
                ),
              ),
              EventoHorizontal(
                  verbenas: state.localidad.verbenas,
                  altura: _screenSize.height * 0.4,
                  ancho: _screenSize.width)
            ],
          ),
        );
      },
    );
  }
}

class SelectProvincias extends StatelessWidget {
  SelectProvincias({this.enabled});

  final enabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropDownProvinciasBloc, DropDownProvinciasState>(
      builder: (context, state) {
        if (state.status == DropDownProvinciasStatus.initial) {
          context.read<DropDownProvinciasBloc>().add(DropDownProvinciasEvent());

          return CircularProgressIndicator();
        }

        return DropDownProvincias(
          provincias: state.provincias,
          enabled: enabled,
        );
      },
    );
  }
}

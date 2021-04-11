import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/src/pages/buscar/bloc.dart';

import 'dd_provincias.dart';

class AppBarMapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Mapa(sc: _sc),
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
          right: state.visible ? screenSize.width : 0,
          top: screenSize.height * 0.04,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: BannerBusqueda(),
        );
      },
    );
  }
}

class BannerBusqueda extends StatefulWidget {
  @override
  _BannerBusquedaState createState() => _BannerBusquedaState();
}

class _BannerBusquedaState extends State<BannerBusqueda> {
  bool isPorProvincia = true;
  bool celebrandose = false;
  Provincia provincia;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width,
        child: BlocListener<FormBusquedaBloc, FormBusquedaState>(
          listener: (context, state) {
            if (state.status == FormBusquedaStatus.invalid) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.deepOrangeAccent,
                content: Text('Activa tu ubicación o elige una provincia',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ));
            } else if (state.status == FormBusquedaStatus.porProvincia) {
              setState(() {
                provincia = state.provincia;
              });
            }

            setState(() {
              isPorProvincia = state.ubicacion == null;
              celebrandose = state.checkValue;
            });
          },
          child: Row(
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
                            onChanged: (val) => (val)
                                ? BlocProvider.of<FormBusquedaBloc>(context)
                                    .add(PorUbicacion())
                                : BlocProvider.of<FormBusquedaBloc>(context)
                                    .add(PorProvincia(provincia: provincia)),
                          ),
                          Switch(
                            activeColor: Colors.deepOrangeAccent,
                            value: isPorProvincia,
                            onChanged: (val) => (val)
                                ? BlocProvider.of<FormBusquedaBloc>(context)
                                    .add(PorProvincia(provincia: provincia))
                                : BlocProvider.of<FormBusquedaBloc>(context)
                                    .add(PorUbicacion()),
                          ),
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                activeColor: Colors.deepOrangeAccent,
                                value: celebrandose,
                                onChanged: (value) {
                                  context
                                      .read<FormBusquedaBloc>()
                                      .add(CambiaCheck(value: value));
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
                onPressed: () => context.read<FormBusquedaBloc>().add(Buscar()),
              ),
            ],
          ),
        ));
  }
}

class Mapa extends StatefulWidget {
  final sc;

  Mapa({this.sc});
  @override
  _MapaState createState() => _MapaState(sc: sc);
}

class _MapaState extends State<Mapa> {
  List<Marker> marcadores = [];
  _MapaState({this.sc});
  final sc;
  final MapController _mapController = MapController();
  LatLng _location;
  Provincia provincia;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormBusquedaBloc, FormBusquedaState>(
        listener: (context, state) {
      if (state.status == FormBusquedaStatus.empty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.deepOrangeAccent,
          content: Text('Oops! No hay resultados :(',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ));
      } else if (state.provincia != null || state.ubicacion != null) {
        List<Localidad> localidades = [];
        List<Marker> markers = <Marker>[];
        if (state.provincia != null) {
          setState(() {
            provincia = state.provincia;
          });
          localidades = provincia.localidades;
          _mapController.move(LatLng(provincia.latitud, provincia.longitud), 8);
        } else {
          if (_location == null) _location = state.ubicacion.coord;
          localidades = state.ubicacion.localidades;
          markers = [
            Marker(
              point: _location,
              builder: (ctx) => IconButton(
                icon: Icon(Icons.accessibility),
                color: Colors.deepOrangeAccent,
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    _mapController.move(
                      LatLng(_location.latitude, _location.longitude),
                      14,
                    );
                  });
                },
              ),
            ),
          ];

          _mapController.move(markers[0].point, 8);
        }

        localidades.forEach(
          (l) => markers.add(Marker(
            point: LatLng(l.latitud, l.longitud),
            builder: (ctx) => IconButton(
              icon: Icon(Icons.emoji_emotions_rounded),
              color: Colors.deepOrangeAccent,
              iconSize: 30,
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
          )),
        );

        setState(() {
          marcadores = markers;
        });
      }
    }, child: BlocBuilder<FormBusquedaBloc, FormBusquedaState>(
            builder: (context, state) {
      return FlutterMap(
        mapController: _mapController,
        options: MapOptions(
            center: LatLng(36.716667, -4.416667),
            zoom: 6,
            controller: _mapController),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(markers: marcadores),
        ],
      );
    }));
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
            onPressed: () => BlocProvider.of<BannerVisibleBloc>(context)
                .add(BannerVisibleEvent(!state.visible)),
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

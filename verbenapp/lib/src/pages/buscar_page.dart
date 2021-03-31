import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:verbenapp/src/bloc/provider.dart';
import 'package:verbenapp/src/models/provincia.dart';
import 'package:verbenapp/src/widgets/dropdown_provincias.dart';
import 'package:verbenapp/src/widgets/verbena_horizontal.dart';

class BuscarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    Provider.ofFormMapa(context).crearProvinciasDropdown();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          elevation: 2.0,
          backgroundColor: Colors.indigoAccent,
          expandedHeight: _sc.height * 0.9,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: _appBar(context),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [_containerVerbenas(context)],
          ),
        )
      ]),
    );
  }

  Widget _appBar(context) {
    final bloc = Provider.ofFormMapa(context);
    final _sc = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Mapa(),
        BannerDinamico(
          screenSize: _sc,
        ),
        Positioned(
          top: _sc.height * 0.108,
          right: 10,
          child: FloatingActionButton(
            heroTag: 'button-search',
            child: Icon(
              Icons.search,
              size: 30,
            ),
            backgroundColor: Colors.deepOrangeAccent,
            onPressed: () {
              var value = false;
              if (bloc.bannerVisible != null) value = bloc.bannerVisible;
              bloc.changeBannerVisibleSwitch(!value);
            },
          ),
        ),
      ],
    );
  }

  Widget _containerVerbenas(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width,
      child: StreamBuilder(
        stream: Provider.ofLocalidades(context).localidadSeleccionadaMapaStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Text('Pincha en alguna localidad para ver sus fiestas'),
            );
          final localidad = snapshot.data;

          return Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${localidad.nombre}',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent),
                  ),
                ),
              ),
              EventoHorizontal(
                  verbenas: localidad.verbenas,
                  altura: _screenSize.height * 0.4,
                  ancho: _screenSize.width)
            ],
          );
        },
      ),
    );
  }
}

class BannerDinamico extends StatelessWidget {
  final screenSize;

  BannerDinamico({@required this.screenSize});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: false,
      stream: Provider.ofFormMapa(context).bannerVisibleStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        var visible = snapshot.data;
        return AnimatedPositioned(
          right: visible ? 0 : screenSize.width,
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
    final blocForm = Provider.ofFormMapa(context);
    final screenSize = MediaQuery.of(context).size;
    final mapBloc = Provider.ofMapa(context);
    return Container(
      width: screenSize.width,
      child: StreamBuilder(
        initialData: true,
        stream: blocForm.switchStream,
        builder: (context, snapshot) {
          var _value = snapshot.data;
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
                              value: !_value,
                              onChanged: (value) {
                                blocForm.changeSwitch(!_value);
                                if (value) mapBloc.init();
                                blocForm.changeCambiosBusqueda(true);
                              }),
                          Switch(
                              activeColor: Colors.deepOrangeAccent,
                              value: _value,
                              onChanged: (value) {
                                blocForm.changeSwitch(!_value);
                                blocForm.changeCambiosBusqueda(true);
                              }),
                          Transform.scale(
                            scale: 1.5,
                            child: StreamBuilder(
                                initialData: false,
                                stream: blocForm.proximasStream,
                                builder: (context, snapshot) {
                                  return new Checkbox(
                                      activeColor: Colors.deepOrangeAccent,
                                      value: snapshot.data,
                                      onChanged: (value) {
                                        blocForm.changeCheckProximas(value);
                                        blocForm.changeCambiosBusqueda(true);
                                      });
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
                              child: SelectProvincias(_value)),
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
              BotonGuardar()
            ],
          );
        },
      ),
    );
  }
}

class Mapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapaBloc = Provider.ofMapa(context);
    return StreamBuilder(
        initialData: [],
        stream: Provider.ofLocalidades(context).localidadesMapaStream,
        builder: (context, snapshot) => FlutterMap(
              mapController: mapaBloc.mapController,
              options: mapaBloc.initialMapOptions,
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(
                    markers: construyeMarcadores(snapshot.data, context)),
              ],
            ));
  }

  List<Marker> construyeMarcadores(localidades, context) {
    List<Marker> marcadores = [];
    final bloc = Provider.ofMapa(context);
    if (bloc.ubicacion != null) {
      marcadores.add(Marker(
          builder: (context) => Icon(
                Icons.directions_run,
                color: Colors.deepPurpleAccent,
                size: 30,
              ),
          point: LatLng(bloc.ubicacion.latitude, bloc.ubicacion.longitude)));
    }
    if (localidades.isEmpty) return marcadores;
    localidades.forEach((localidad) => marcadores.add(Marker(
        point: localidad.coord,
        builder: (context) => GestureDetector(
            child: Icon(
              Icons.emoji_emotions_rounded,
              color: Colors.deepOrangeAccent,
              size: 50,
            ),
            onTap: () {
              Provider.ofMapa(context).mapController.moveAndRotate(
                  localidad.coord,
                  12,
                  -Provider.ofMapa(context).mapController.rotation);
              Provider.ofLocalidades(context)
                  .changelocalidadSeleccionadaMapa(localidad);
            }))));
    return marcadores;
  }
}

class BotonGuardar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocForm = Provider.ofFormMapa(context);
    return StreamBuilder(
      initialData: false,
      stream: blocForm.cambiosBusquedaStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        var _onPress;
        if (snapshot.data) _onPress = validaBusqueda(context);
        //Va a buscar por provincia

        return Container(
          child: FloatingActionButton(
              heroTag: 'button-save',
              child: Icon(
                Icons.check,
                size: 30,
              ),
              backgroundColor: Colors.deepOrangeAccent,
              onPressed: _onPress),
        );
      },
    );
  }

  void Function() validaBusqueda(context) {
    final mapBloc = Provider.ofMapa(context);
    final blocLoc = Provider.ofLocalidades(context);
    final blocForm = Provider.ofFormMapa(context);

    var porProvincias = true;

    if (blocForm.switchBusqueda != null)
      porProvincias = blocForm.switchBusqueda;

    // Va a buscar localidades que tengan verbenas celebrandose
    if (porProvincias) {
      if (blocForm.provinciaSeleccionada == null) {
        return () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.deepOrangeAccent,
              content: Text("Debes seleccionar una provincia")));
        };
      }
      if (blocForm.proximasCheck != null && blocForm.proximasCheck) {
        return () {
          blocLoc.localidadesCelebrandosePorProvincia(
              blocForm.provinciaSeleccionada);
          mapBloc.mapController.move(blocForm.provinciaSeleccionada.coord, 8);
          blocForm.changeBannerVisibleSwitch(false);
        };
      }

      return () {
        blocLoc.localidadesFromProvincia(blocForm.provinciaSeleccionada);
        mapBloc.mapController.move(blocForm.provinciaSeleccionada.coord, 8);
        blocForm.changeBannerVisibleSwitch(false);
      };
    }

    if (mapBloc.ubicacion == null) {
      return () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.deepOrangeAccent,
            content: Text("Debes darle permisos de ubicación a la app")));
      };
    }
    var coord = LatLng(mapBloc.ubicacion.latitude, mapBloc.ubicacion.longitude);
    if (blocForm.proximasCheck != null && blocForm.proximasCheck) {
      return () {
        blocLoc.localidadesCelebrandosePorUbicacion(coord);
        mapBloc.mapController.move(coord, 8);
        blocForm.changeBannerVisibleSwitch(false);
      };
    }

    return () {
      blocLoc.localidadesFromUbicacion(coord);
      mapBloc.mapController.move(coord, 8);
      blocForm.changeBannerVisibleSwitch(false);
    };
  }
}

class SelectProvincias extends StatelessWidget {
  final bool enabled;
  SelectProvincias(this.enabled);
  @override
  Widget build(BuildContext context) {
    final blocForm = Provider.ofFormMapa(context);
    return StreamBuilder(
      stream: blocForm.provinciasDropdownStream,
      builder: (context, AsyncSnapshot<List<Provincia>> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return DropDownProvincias(provincias: snapshot.data, enabled: enabled);
      },
    );
  }
}

// Widget _infoVerbena(BuildContext context) {
//   final _screenSize = MediaQuery.of(context).size;
//   final bloc = Provider.ofVerbenas(context);
//   return StreamBuilder(
//       stream: bloc.verbenaStream,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final verbena = snapshot.data;
//           return Container(
//             height: _screenSize.height * 0.2,
//             width: _screenSize.width * 0.2,
//             child: Column(
//               children: [
//                 Text(verbena.nombre),
//                 Text(verbena.localidad),
//               ],
//             ),
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       });
// }

// void _init(BuildContext context) {
//   Provider.ofMapa(context).init();
// }

// GoogleMap(
//                         mapToolbarEnabled: false,
//                         myLocationButtonEnabled: true,
//                         mapType: MapType.normal,
//                         myLocationEnabled: true,
//                         onMapCreated: (GoogleMapController controller) {
//                           _controller.complete(controller);
//                         },
//                         initialCameraPosition: CameraPosition(
//                             target: LatLng(latSpn, longSpn), zoom: 5.7),
//                         markers: _marcadores,
//                       ),

//  Marker(
//                 markerId: MarkerId(verbena.nombre),
//                 position: LatLng(verbena.latitud, verbena.longitud),
//                 infoWindow: InfoWindow(
//                     title: verbena.nombre,
//                     snippet: verbena.localidad,
//                     onTap: () {
//                       Navigator.pushNamed(context, 'detalle',
//                           arguments: verbena);
//                     }),
//                 onTap: () {
//                   Provider.ofVerbenas(context).changeVerbena(verbena);
//                 })

// IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//                     showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             backgroundColor: Color(0xFFDBFE68),
//                             title: Text('Busca verbenas'),
//                             content: Container(
//                               child: _formBusqueda(context),
//                             ),
//                             actions: <Widget>[
//                               Container(
//                                 margin: EdgeInsets.all(20),
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                       primary: Colors.deepPurpleAccent),
//                                   child: Text('Guardar',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       )),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               )
//                             ],
//                           );
//                         });
//                   })

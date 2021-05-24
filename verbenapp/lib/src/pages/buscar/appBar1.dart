// import 'package:flutter/material.dart';

// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong/latlong.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:Verbenapp/src/pages/buscar/verbena_horizontal.dart';

// import 'buscar.dart';
// import 'dd_provincias.dart';

// ///
// /// AppBar desplegable que contendrá
// /// el mapa y el formulario de busqueda
// ///
// class AppBarMapa extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final _sc = MediaQuery.of(context).size;
//     return Stack(
//       alignment: AlignmentDirectional.bottomCenter,
//       children: [
//         Mapa(sc: _sc),
//         BannerDinamico(
//           screenSize: _sc,
//         ),
//         BotonBusqueda(sc: _sc),
//         Container(
//           margin: const EdgeInsets.all(10.0),
//           child: ElevatedButton(
//               style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all(Colors.deepOrangeAccent)),
//               child: Text(
//                 'Ver resultados',
//                 style: TextStyle(fontSize: 24),
//               ),
//               onPressed: () {
//                 showModalBottomSheet(
//                     context: context,
//                     builder: (context) {
//                       return Container(
//                         height: _sc.height * 0.5,
//                         width: _sc.width * 0.5,
//                         child: ContainerVerbenas(),
//                       );
//                     });
//               }),
//         ),
//       ],
//     );
//   }
// }

// ///
// /// Contiene al formulario de busqueda y
// /// permite mostrarse y ocultarse
// ///
// class BannerDinamico extends StatelessWidget {
//   final screenSize;

//   BannerDinamico({@required this.screenSize});
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BannerVisibleBloc, BannerVisibleState>(
//       builder: (context, state) {
//         return AnimatedPositioned(
//           right: state.visible ? screenSize.width : 0,
//           top: screenSize.height * 0.04,
//           duration: const Duration(seconds: 1),
//           curve: Curves.fastOutSlowIn,
//           child: BannerBusqueda(),
//         );
//       },
//     );
//   }
// }

// ///
// /// Formulario para realizar búsquedas con
// /// filtros
// ///
// class BannerBusqueda extends StatefulWidget {
//   @override
//   _BannerBusquedaState createState() => _BannerBusquedaState();
// }

// class _BannerBusquedaState extends State<BannerBusqueda> {
//   bool isPorProvincia = true;
//   bool celebrandose = false;
//   Provincia provincia;
//   LocationData ubicacion;
//   var onPressed;

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Container(
//         width: screenSize.width,
//         child: BlocListener<BannerBusquedaBloc, BannerBusquedaState>(
//           listener: (context, state) {
//             if (state.status == BannerBusquedaStatus.invalid) {
//               setState(() {
//                 onPressed = null;
//               });
//             } else {
//               if (isPorProvincia) {
//                 setState(() {
//                   if (state.provincia != null) provincia = state.provincia;
//                   onPressed = () => context.read<FormBusquedaBloc>().add(
//                       FormBusquedaEvent(
//                           ubi: null, prov: provincia, byDelMes: celebrandose));
//                 });
//               } else {
//                 setState(() {
//                   if (state.ubicacion != null) ubicacion = state.ubicacion;
//                   onPressed = () => context.read<FormBusquedaBloc>().add(
//                       FormBusquedaEvent(
//                           ubi: ubicacion, prov: null, byDelMes: celebrandose));
//                 });
//               }
//             }
//           },
//           child: Row(
//             children: [
//               Container(
//                 width: screenSize.width * 0.68,
//                 height: screenSize.height * 0.22,
//                 child: Row(
//                   children: [
//                     Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Switch(
//                               activeColor: Colors.deepOrangeAccent,
//                               value: !isPorProvincia,
//                               onChanged: (val) {
//                                 setState(() {
//                                   isPorProvincia = !val;
//                                 });
//                                 _onChangeSwitch(context);
//                               }),
//                           Switch(
//                               activeColor: Colors.deepOrangeAccent,
//                               value: isPorProvincia,
//                               onChanged: (val) {
//                                 setState(() {
//                                   isPorProvincia = val;
//                                 });
//                                 _onChangeSwitch(context);
//                               }),
//                           Transform.scale(
//                             scale: 1.5,
//                             child: Checkbox(
//                                 activeColor: Colors.deepOrangeAccent,
//                                 value: celebrandose,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     celebrandose = value;
//                                   });
//                                   context
//                                       .read<BannerBusquedaBloc>()
//                                       .add(CambiaCheck(value: celebrandose));
//                                 }),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Cerca de mí',
//                             style: TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.bold),
//                           ),
//                           Padding(padding: EdgeInsets.all(5)),
//                           Container(
//                               height: screenSize.height * 0.07,
//                               width: screenSize.width * 0.5,
//                               child: SelectProvincias(enabled: isPorProvincia)),
//                           Padding(padding: EdgeInsets.all(5)),
//                           Text(
//                             'Próximas',
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               FloatingActionButton(
//                   heroTag: 'button-save',
//                   child: Icon(
//                     Icons.search,
//                     size: 30,
//                   ),
//                   backgroundColor: Colors.deepOrangeAccent,
//                   onPressed: () {
//                     (onPressed == null)
//                         ? ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               backgroundColor: Colors.deepOrangeAccent,
//                               content: Text(
//                                 'Activa tu ubicación o elige una provincia',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 20),
//                               ),
//                             ),
//                           )
//                         : onPressed();
//                   }),
//             ],
//           ),
//         ));
//   }

//   _onChangeSwitch(context) {
//     (isPorProvincia)
//         ? BlocProvider.of<BannerBusquedaBloc>(context)
//             .add(PorProvincia(provincia: provincia))
//         : BlocProvider.of<BannerBusquedaBloc>(context)
//             .add(PorUbicacion(ubicacion: ubicacion));
//   }
// }

// ///
// /// Mapa que muestra los resultados de
// /// la busqueda del usuario
// ///
// class Mapa extends StatefulWidget {
//   final sc;

//   Mapa({this.sc});
//   @override
//   _MapaState createState() => _MapaState(sc: sc);
// }

// class _MapaState extends State<Mapa> {
//   List<Marker> marcadores = [];
//   _MapaState({this.sc});
//   final sc;
//   final MapController _mapController = MapController();
//   LocationData _location;
//   Provincia provincia;

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//         listeners: [
//           BlocListener<BannerBusquedaBloc, BannerBusquedaState>(
//             listener: (context, state) {
//               if (state.status == BannerBusquedaStatus.porProvincia) {
//                 setState(() {
//                   if (state.provincia != null) provincia = state.provincia;
//                   marcadores = <Marker>[
//                     Marker(
//                       point: LatLng(provincia.latitud, provincia.longitud),
//                       builder: (ctx) => IconButton(
//                         icon: Icon(Icons.location_on_rounded),
//                         color: Colors.red,
//                         iconSize: 30,
//                         onPressed: () {
//                           setState(() {
//                             _mapController.move(
//                               LatLng(provincia.latitud, provincia.longitud),
//                               14,
//                             );
//                           });
//                         },
//                       ),
//                     ),
//                   ];
//                   _mapController.move(
//                       LatLng(provincia.latitud, provincia.longitud), 8);
//                 });
//               } else if (state.status == BannerBusquedaStatus.porUbicacion) {
//                 setState(() {
//                   if (state.ubicacion != null) _location = state.ubicacion;
//                   marcadores = <Marker>[
//                     Marker(
//                       point: LatLng(_location.latitude, _location.longitude),
//                       builder: (ctx) => IconButton(
//                         icon: Icon(Icons.accessibility),
//                         color: Colors.deepOrangeAccent,
//                         iconSize: 40,
//                         onPressed: () {
//                           setState(() {
//                             _mapController.move(
//                               LatLng(_location.latitude, _location.longitude),
//                               14,
//                             );
//                           });
//                         },
//                       ),
//                     ),
//                   ];
//                   _mapController.move(
//                       LatLng(_location.latitude, _location.longitude), 8);
//                 });
//               }
//             },
//           ),
//           BlocListener<FormBusquedaBloc, FormBusquedaState>(
//               listener: (context, state) {
//             if (state.status == FormBusquedaStatus.empty) {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 backgroundColor: Colors.deepOrangeAccent,
//                 content: Text('Oops! No hay resultados :(',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//               ));
//             } else if (state.status == FormBusquedaStatus.sucess) {
//               final results = marcadores;

//               state.locs.forEach(
//                 (l) => results.add(Marker(
//                   point: LatLng(l.latitud, l.longitud),
//                   builder: (ctx) => IconButton(
//                     icon: Icon(Icons.emoji_emotions_rounded),
//                     color: Colors.deepOrangeAccent,
//                     iconSize: 30,
//                     onPressed: () {
//                       setState(() {
//                         _mapController.move(
//                           LatLng(l.latitud, l.longitud),
//                           14,
//                         );
//                       });
//                       context
//                           .read<LocalidadSeleccionadaBloc>()
//                           .add(ChangeLoc(data: l));
//                     },
//                   ),
//                 )),
//               );
//               setState(() {
//                 marcadores = results;
//               });
//             }
//           }),
//         ],
//         child: FlutterMap(
//           mapController: _mapController,
//           options: MapOptions(
//               center: LatLng(36.716667, -4.416667),
//               zoom: 6,
//               controller: _mapController),
//           layers: [
//             TileLayerOptions(
//                 urlTemplate:
//                     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 subdomains: ['a', 'b', 'c']),
//             MarkerLayerOptions(markers: marcadores),
//           ],
//         ));
//   }
// }

// ///
// /// Boton que muestra/oculta el formulario
// ///
// class BotonBusqueda extends StatelessWidget {
//   final sc;
//   BotonBusqueda({this.sc});
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BannerVisibleBloc, BannerVisibleState>(
//       builder: (context, state) {
//         return Positioned(
//           top: sc.height * 0.108,
//           right: sc.width * 0.02,
//           child: FloatingActionButton(
//             heroTag: 'button-search',
//             child: Icon(
//               Icons.filter_alt_rounded,
//               size: 30,
//             ),
//             backgroundColor: Colors.deepOrangeAccent,
//             onPressed: () => BlocProvider.of<BannerVisibleBloc>(context)
//                 .add(BannerVisibleEvent(!state.visible)),
//           ),
//         );
//       },
//     );
//   }
// }

// ///
// /// DropDown de Pronvincia para el formulario
// /// de búsqueda
// ///
// class SelectProvincias extends StatelessWidget {
//   SelectProvincias({this.enabled});

//   final enabled;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DropDownProvinciasBloc, DropDownProvinciasState>(
//       builder: (context, state) {
//         if (state.status == DropDownProvinciasStatus.initial) {
//           context.read<DropDownProvinciasBloc>().add(DropDownProvinciasEvent());

//           return CircularProgressIndicator();
//         }

//         return DropDownProvincias(
//           provincias: state.provincias,
//           enabled: enabled,
//         );
//       },
//     );
//   }
// }

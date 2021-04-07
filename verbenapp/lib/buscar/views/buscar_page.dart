import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/buscar/bloc/bloc.dart';
import 'package:verbenapp/src/bloc/provider.dart';

import 'appBar.dart';

class BuscarPage2 extends StatelessWidget {
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

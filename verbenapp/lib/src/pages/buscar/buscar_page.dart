import 'package:Verbenapp/src/BL/bl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appBar.dart';
import 'blocs/BannerBusqueda/banner_busqueda_bloc.dart';
import 'blocs/BannerVisible/banner_visible_bloc.dart';
import 'blocs/DropDownProvincias/dropdown_provincias_bloc.dart';
import 'blocs/FormBusqueda/form_busqueda_bloc.dart';

///
/// Vista de Búsqueda
///
class BuscarPage extends StatelessWidget {
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
      ],
      child: Scaffold(
        body: _BuscarPage(),
      ),
    );
  }
}

class _BuscarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return Container(height: _sc.height, width: _sc.width, child: AppBarMapa());
  }
}
// class _BuscarPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final _sc = MediaQuery.of(context).size;
//     return CustomScrollView(slivers: [
//       SliverAppBar(
//         automaticallyImplyLeading: false,
//         elevation: 2.0,
//         backgroundColor: Colors.indigoAccent,
//         expandedHeight: _sc.height * 0.9,
//         floating: false,
//         pinned: true,
//         flexibleSpace: FlexibleSpaceBar(
//           centerTitle: true,
//           background: AppBarMapa(),
//         ),
//       ),
//       SliverList(
//         delegate: SliverChildListDelegate(
//           [ContainerVerbenas()],
//         ),
//       )
//     ]);
//   }
// }

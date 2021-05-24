import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Verbenapp/src/DAL/models/verbena.dart';

// import 'blocs/LocalidadSeleccionada/localidad_seleccionada_bloc.dart';

///
/// Container que tendrá la Localidad
/// seleccionada por el usuario con sus
/// diferentes fiestas
///
class ContainerVerbenas extends StatelessWidget {
  ContainerVerbenas({this.provincia, this.localidades});
  final localidades;
  final provincia;
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    if (localidades.isEmpty)
      return Container(
        padding: EdgeInsets.all(10),
        width: _screenSize.width,
        child: Center(child: Text('¡Vaya! No hay resultados de tu búsqueda.')),
      );
    var verbenas = <Verbena>[];
    localidades.forEach((l) => verbenas += l.verbenas);
    return Container(
      width: _screenSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              width: _screenSize.width,
              height: _screenSize.height * 0.05,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  provincia,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent),
                ),
              ),
            ),
          ),
          EventoHorizontal(verbenas: verbenas, ancho: _screenSize.width),
          Container(
            child: Text((verbenas.length > 1)
                ? 'Desliza abajo para ver más resultados'
                : ''),
          )
        ],
      ),
    );
  }
}

///
/// Vista scrollabe de las distintas
/// fiestas de la localidad seleccionada por
/// el usuario
///
class EventoHorizontal extends StatelessWidget {
  final List<Verbena> verbenas;

  final double ancho;

  EventoHorizontal({@required this.verbenas, @required this.ancho});

  final _pageController = new PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return Container(
      height: sc.height * 0.4,
      width: ancho,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        pageSnapping: false,
        controller: _pageController,
        itemCount: verbenas.length,
        itemBuilder: (context, i) => _tarjeta(context, verbenas[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Verbena verbena) {
    final sc = MediaQuery.of(context).size;
    verbena.uniqueId = '${verbena.nombre}-mapa';

    final tarjeta = Container(
      padding: EdgeInsets.all(5),
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            width: ancho,
            child: Hero(
              tag: verbena.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/loading.gif'),
                  image: NetworkImage(verbena.img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            height: sc.height * 0.08,
            width: ancho * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepOrangeAccent,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  verbena.nombre,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],

        // ),
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: verbena);
      },
    );
  }
}

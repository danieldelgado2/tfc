import 'package:flutter/material.dart';
import 'package:verbenapp/src/DAL/models/verbena.dart';

class EventoHorizontal extends StatelessWidget {
  final List<Verbena> verbenas;
  final double altura;
  final double ancho;

  EventoHorizontal(
      {@required this.verbenas, @required this.altura, @required this.ancho});

  final _pageController = new PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: altura,
      width: ancho,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: verbenas.length,
        itemBuilder: (context, i) => _tarjeta(context, verbenas[i], altura),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Verbena verbena, double altura) {
    verbena.uniqueId = '${verbena.nombre}-mapa';

    final tarjeta = Container(
      padding: EdgeInsets.all(5),
      width: ancho,
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
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
            height: altura * 0.2,
            width: ancho * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepOrangeAccent,
            ),
            child: Center(
              child: Text(
                verbena.nombre,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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

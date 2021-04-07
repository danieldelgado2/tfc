import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verbenapp/src/DAL/models/verbena.dart';

class DetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Verbena verbena = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(slivers: [
        _crearAppBar(verbena, context),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              verbena.nombre,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          _detalles(verbena, context),
          _descripcion(verbena),
          _comoLlegar(context, verbena.url),
          // _mapa(verbena, context)
        ])),
      ]),
    );
  }

  Widget _crearAppBar(Verbena verbena, BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.deepOrangeAccent,
      expandedHeight: MediaQuery.of(context).size.height * 0.4,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Hero(
          tag: verbena.uniqueId,
          child: FadeInImage(
            image: NetworkImage(
              verbena.getImg(),
            ),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _detalles(Verbena verbena, BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child:
                    Icon(Icons.calendar_today, color: Colors.deepOrangeAccent),
              ),
              Text(
                verbena.desde + " - " + verbena.hasta,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.location_on_rounded,
                      color: Colors.deepOrangeAccent)),
              Container(
                width: sc.width * 0.7,
                child: Text('${verbena.localidad}, ${verbena.provincia}',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _descripcion(Verbena verbena) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        verbena.descripcion,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18, letterSpacing: 1),
      ),
    );
  }

  Widget _comoLlegar(context, url) {
    final sc = MediaQuery.of(context).size;
    return Container(
      width: sc.width * 0.4,
      height: sc.height * 0.08,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.deepOrangeAccent)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '!Voy para alla!',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            Icon(
              Icons.directions_run,
              size: 30,
            )
          ],
        ),
        onPressed: () => launch(url),
      ),
    );
  }
}

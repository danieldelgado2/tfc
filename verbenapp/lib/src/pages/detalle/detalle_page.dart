import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verbenapp/src/DAL/models/verbena.dart';
import 'package:verbenapp/src/pages/detalle/star_rating.dart';

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
          Botones(verbena: verbena),
          _descripcion(verbena),
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
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        verbena.descripcion,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18, letterSpacing: 1),
      ),
    );
  }
}

class Botones extends StatelessWidget {
  final verbena;
  Botones({this.verbena});
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return Container(
      height: _sc.height * 0.1,
      width: _sc.width,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BotonTripAdvisor(navigationUrl: verbena.urlTrip),
          BotonDescarga(navigationUrl: verbena.urlDoc),
          BotonMaps(navigationUrl: verbena.url),
        ],
      ),
    );
  }
}

class BotonComentarios extends StatelessWidget {
  BotonComentarios();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
            onTap: () => Scaffold.of(context).openDrawer(), // needed
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.deepOrangeAccent,
              ),
              padding: EdgeInsets.all(15),
              child: Image.asset(
                'assets/img/comments.png',
                fit: BoxFit.cover,
              ),
            )));
  }
}

class BotonTripAdvisor extends StatelessWidget {
  final navigationUrl;
  BotonTripAdvisor({this.navigationUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
            onTap: () => launch(navigationUrl), // needed
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.deepOrangeAccent,
              ),
              child: Image.asset(
                'assets/img/tripadvisor-icon.png',
                fit: BoxFit.cover,
              ),
            )));
  }
}

class BotonDescarga extends StatelessWidget {
  final navigationUrl;
  BotonDescarga({this.navigationUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.deepOrangeAccent,
          ),
          padding: EdgeInsets.all(10),
          child: Image.asset(
            'assets/img/happy-file.png',
            fit: BoxFit.cover,
          ),
        ),
        onTap: () async {
          launch(navigationUrl);
          // Use location.
        }, // needed
      ),
    );
  }
}

class BotonMaps extends StatelessWidget {
  final navigationUrl;
  BotonMaps({this.navigationUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.deepOrangeAccent,
      ),
      child: InkWell(
        onTap: () => launch(navigationUrl), // needed
        child: Icon(
          Icons.location_on_rounded,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}

class Comentarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return Container(
      height: _sc.height,
      width: _sc.width,
      color: Colors.greenAccent,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Valoraciones',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Comentario(),
            FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AgregarComentario());
                })
          ],
        ),
      ),
    );
  }
}

class Comentario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return Card(
      color: Colors.amber,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        height: _sc.height * 0.3,
        width: _sc.width,
        child: Column(
          children: [
            Text(
                'Holaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaolaola')
          ],
        ),
      ),
    );
  }
}

class AgregarComentario extends StatefulWidget {
  @override
  _AgregarComentarioState createState() => _AgregarComentarioState();
}

class _AgregarComentarioState extends State<AgregarComentario> {
  TextEditingController controller;
  FocusNode focus;
  @override
  void initState() {
    controller = TextEditingController();
    focus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: _sc.height * 0.45,
        width: _sc.width,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Añade una valoración',
                style: TextStyle(
                  fontSize: 24,
                )),
            StarRating(
              rating: 3,
              onRatingChanged: null,
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                height: _sc.height * 0.2,
                width: _sc.width,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.deepOrangeAccent, width: 2)),
                child: ListView(
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: null,
                      decoration: null,
                      focusNode: focus,
                    ),
                  ],
                ),
              ),
              onTap: () {
                focus.requestFocus();
              },
            ),
            ElevatedButton(child: Text('Valorar'), onPressed: () {})
          ],
        ),
      ),
    );
  }
}

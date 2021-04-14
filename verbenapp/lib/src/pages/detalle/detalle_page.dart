import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verbenapp/src/DAL/models/verbena.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
          _comoLlegar(context, verbena.url),
          // _mapa(verbena, context)
        ])),
      ]),
    );
  }

  Widget _crearAppBar(Verbena verbena, BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl:
                            'https://www.tripadvisor.com/Tourism-g265784-Ronda_Costa_del_Sol_Province_of_Malaga_Andalucia-Vacations.html',
                      ),
                    ),
                  );
                });
          },
        )
      ],
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
        onPressed: () => launch(
            'https://www.tripadvisor.com/Tourism-g265784-Ronda_Costa_del_Sol_Province_of_Malaga_Andalucia-Vacations.html'),
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
          BotonComentarios(
              img: 'comments.png',
              navigationUrl:
                  'https://www.youtube.com/watch?v=I3bhRb6f5dA&ab_channel=RajaYogan'),
          BotonTripAdvisor(
              img: 'tripadvisor-icon.png', navigationUrl: verbena.url_trip),
          BotonDescarga(verbena: verbena),
          BotonMaps(navigationUrl: 'https://goo.gl/maps/pJbCeCS2P8DNjNV76'),
        ],
      ),
    );
  }
}

class Boton extends StatelessWidget {
  final img;
  final navigationUrl;
  Boton({this.img, this.navigationUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.orange,
        child: InkWell(
            onTap: () => launch(navigationUrl), // needed
            child: Container(
              color: Colors.red,
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/img/' + img,
                fit: BoxFit.cover,
              ),
            )));
  }
}

class BotonComentarios extends StatelessWidget {
  final img;
  final navigationUrl;
  BotonComentarios({this.img, this.navigationUrl});

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
              padding: EdgeInsets.all(15),
              child: Image.asset(
                'assets/img/comments.png',
                fit: BoxFit.cover,
              ),
            )));
  }
}

class BotonTripAdvisor extends StatelessWidget {
  final img;
  final navigationUrl;
  BotonTripAdvisor({this.img, this.navigationUrl});

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
  final verbena;
  BotonDescarga({this.verbena});

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
          WidgetsFlutterBinding.ensureInitialized();
          await FlutterDownloader.initialize(debug: true);
          final taskId = await FlutterDownloader.enqueue(
            url: verbena.img,
            savedDir: '/' + verbena.img,
            fileName: 'Agenda de ' + verbena.nombre,
            showNotification:
                true, // show download progress in status bar (for Android)
            openFileFromNotification:
                true, // click on notification to open downloaded file (for Android)
          );
          print(taskId);
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

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _login(context));
  }

  Widget _login(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width,
      height: _screenSize.height,
      child: Column(
        children: [
          _logo(context),
          _botones(context)

          // _footer(context)
        ],
      ),
    );
  }

  Widget _logo(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width,
      height: _screenSize.height * 0.4,
      child: Image(image: AssetImage('assets/img/Verbenapp.png')),
    );
  }

  Widget _botones(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width,
      height: _screenSize.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _boton('Admin', 'form', context),
          _boton('Buscar', 'buscar', context),
        ],
      ),
    );
  }

  Widget _boton(String texto, String ruta, BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width * 0.5,
      height: _screenSize.height * 0.1,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
            primary: Colors.deepOrangeAccent,
            elevation: 15,
            padding: EdgeInsets.all(10),
            minimumSize:
                Size(_screenSize.width * 0.3, _screenSize.height * 0.05)),
        child: Text(
          texto,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.pushNamed(context, ruta);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/src/pages/form/bloc.dart';

///
/// Contiene los campos relativos
/// a la localidad localidad que se esta editando
///
class FormLocalidad extends StatefulWidget {
  @override
  _FormLocalidadState createState() => _FormLocalidadState();
}

class _FormLocalidadState extends State<FormLocalidad> {
  Localidad _loc = Localidad(verbenas: []);
  @override
  Widget build(BuildContext context) {
    return BlocListener<FormLocalidadBloc, FormLocalidadState>(
      listener: (context, state) {
        if (state.status != FormLocalidadStatus.initial) {
          setState(() {
            _loc = state.locEditar;
          });
        }
      },
      child: Container(
        child: Column(
          children: [
            Inputs(
              loc: _loc,
            ),
            Text(
              'Verbenas',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            ListaVerbenas(
              verbenas: _loc.verbenas,
            ),
          ],
        ),
      ),
    );
  }
}

///
/// Los TextFormField de los datos de la
/// localidad que se esta editando
///
class Inputs extends StatelessWidget {
  final loc;

  Inputs({this.loc});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Localidad',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            controller: TextEditingController(text: loc.nombre),
            style: TextStyle(fontSize: 22),
            onChanged: (value) {
              context.read<FormLocalidadBloc>().add(ModificarLocalidad(value));
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Provincia',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            controller: TextEditingController(text: loc.provincia),
            style: TextStyle(fontSize: 22),
            onChanged: (value) {
              context.read<FormLocalidadBloc>().add(ModificarProvincia(value));
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Latitud',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            controller: TextEditingController(text: loc.latitud.toString()),
            style: TextStyle(fontSize: 22),
            onChanged: (value) {
              context.read<FormLocalidadBloc>().add(ModificarLatitud(value));
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Longitud',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            controller: TextEditingController(text: loc.longitud.toString()),
            style: TextStyle(fontSize: 22),
            onChanged: (value) {
              context.read<FormLocalidadBloc>().add(ModificarLongitud(value));
            },
          ),
        ],
      ),
    );
  }
}

///
/// Contenedor con todas las verbenas de
/// la localidad que se esta editando
///
class ListaVerbenas extends StatelessWidget {
  final verbenas;
  ListaVerbenas({this.verbenas});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      child: ListView.builder(
        itemCount: verbenas.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.orange, width: 2.5, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10),
            ),
            leading: Icon(Icons.celebration),
            title: Text(verbenas[i].nombre),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                context.read<FormLocalidadBloc>().add(QuitarVerbenas(i));
              },
            ),
            onTap: () {
              context
                  .read<FormVerbenaBloc>()
                  .add(ChangeVerbena(data: verbenas[i]));
            },
          );
        },
      ),
    );
  }
}

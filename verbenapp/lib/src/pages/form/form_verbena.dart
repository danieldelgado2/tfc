import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Verbenapp/src/pages/form/bloc.dart';

///
/// Vista principal del formulario
/// del panel de administración para
/// crear o editar localidades/verbenas
///
///
class FormVerbena extends StatefulWidget {
  final verbena;
  FormVerbena({this.verbena});
  @override
  _FormVerbenaState createState() => _FormVerbenaState();
}

class _FormVerbenaState extends State<FormVerbena> {
  Verbena verbena;
  @override
  void initState() {
    verbena = widget.verbena;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nombre',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            controller: TextEditingController(text: verbena.nombre),
            style: TextStyle(fontSize: 22),
            onChanged: (value) {
              setState(() {
                verbena.nombre = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Descripción',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            controller: TextEditingController(text: verbena.descripcion),
            style: TextStyle(fontSize: 22),
            onChanged: (value) {
              setState(() {
                verbena.descripcion = value;
              });
            },
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Desde',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  controller: TextEditingController(text: verbena.desde),
                  style: TextStyle(fontSize: 22),
                  onChanged: (value) {
                    setState(() {
                      verbena.desde = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Hasta',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  controller: TextEditingController(text: verbena.hasta),
                  style: TextStyle(fontSize: 22),
                  onChanged: (value) {
                    setState(() {
                      verbena.hasta = value;
                    });
                  },
                ),
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Imagen',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            controller: TextEditingController(text: verbena.img),
            style: TextStyle(fontSize: 22),
            onChanged: (value) {
              setState(() {
                verbena.img = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Url',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            controller: TextEditingController(text: verbena.url),
            style: TextStyle(fontSize: 22),
            onChanged: (value) {
              setState(() {
                verbena.url = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Url Trip Advisor',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            controller: TextEditingController(text: verbena.urlTrip),
            style: TextStyle(fontSize: 22),
            onChanged: (value) {
              setState(() {
                verbena.urlTrip = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: Text(
                  'Volver',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: Text(
                  'Guardar',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  context
                      .read<FormLocalidadBloc>()
                      .add(ModificarVerbenas(verbena));
                  context.read<FormVerbenaBloc>().add(ResetFormVerbena());
                  setState(() {
                    verbena = Verbena();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

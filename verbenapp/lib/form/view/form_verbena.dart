import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/form/bloc/bloc.dart';

class FormVerbena extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: BlocBuilder<FormVerbenaBloc, FormVerbenaState>(
      builder: (context, state) {
        return Column(
          children: [
            Center(
              child: ElevatedButton(
                child: Text(
                  'Añadir Verbena',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                onPressed: () {
                  context
                      .read<FormLocalidadBloc>()
                      .add(AgregarVerbenas(state.verbena));
                  context.read<FormVerbenaBloc>().add(ResetFormVerbena());
                },
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              controller: TextEditingController(text: state.verbena.nombre),
              style: TextStyle(fontSize: 22),
              onChanged: (value) {
                context.read<FormVerbenaBloc>().add(NombreV(data: value));
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
              controller:
                  TextEditingController(text: state.verbena.descripcion),
              style: TextStyle(fontSize: 22),
              onChanged: (value) {
                context.read<FormVerbenaBloc>().add(DescripcionV(data: value));
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
                    controller:
                        TextEditingController(text: state.verbena.desde),
                    style: TextStyle(fontSize: 22),
                    onChanged: (value) {
                      context.read<FormVerbenaBloc>().add(DesdeV(data: value));
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
                    controller:
                        TextEditingController(text: state.verbena.hasta),
                    style: TextStyle(fontSize: 22),
                    onChanged: (value) {
                      context.read<FormVerbenaBloc>().add(HastaV(data: value));
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
              controller: TextEditingController(text: state.verbena.img),
              style: TextStyle(fontSize: 22),
              onChanged: (value) {
                context.read<FormVerbenaBloc>().add(ImgV(data: value));
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
              controller: TextEditingController(text: state.verbena.url),
              style: TextStyle(fontSize: 22),
              onChanged: (value) {
                context.read<FormVerbenaBloc>().add(UrlV(data: value));
              },
            ),
            Center(
              child: ElevatedButton(
                child: Text(
                  'Limpiar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                onPressed: () {
                  context.read<FormVerbenaBloc>().add(ResetFormVerbena());
                },
              ),
            ),
          ],
        );
      },
    ));
  }
}

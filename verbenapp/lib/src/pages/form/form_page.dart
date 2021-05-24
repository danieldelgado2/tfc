import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Verbenapp/src/pages/form/bloc.dart';
import 'package:Verbenapp/src/pages/form/dd_localidades.dart';
import 'package:Verbenapp/src/pages/form/form_localidad.dart';

import 'form_verbena.dart';

///
/// Vista principal del formulario
///
class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _FormPage());
  }
}

class _FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      width: _sc.width,
      height: _sc.height,
      child: BlocBuilder<FormLocalidadBloc, FormLocalidadState>(
        builder: (ctx, st) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    DDLocalidades(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text(
                            'Nueva localidad',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            context.read<FormLocalidadBloc>().add(
                                ChangeDD(Localidad(verbenas: <Verbena>[])));
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          child: Text(
                            'Guardar',
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () {
                            context
                                .read<FormLocalidadBloc>()
                                .add(GuardarLocalidad());
                          },
                        ),
                      ],
                    ),
                    FormLocalidad(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

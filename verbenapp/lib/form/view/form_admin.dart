import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/form/bloc/bloc.dart';
import 'package:verbenapp/form/view/dd_localidades.dart';
import 'package:verbenapp/form/view/form_localidad.dart';
import 'package:verbenapp/form/view/view.dart';

class FormAdmin extends StatelessWidget {
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
                    ElevatedButton(
                      child: Text('Guardar'),
                      onPressed: () {
                        context
                            .read<FormLocalidadBloc>()
                            .add(GuardarLocalidad());
                      },
                    ),
                    FormLocalidad(),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    FormVerbena(),
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

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Icon(Icons.info),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbenapp/form/bloc/bloc.dart';
import 'package:verbenapp/provider.dart';

import 'form_admin.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sc = MediaQuery.of(context).size;
    final _locBL = Provider.ofLocalidadBL(context);
    return Scaffold(
        body: Container(
      height: _sc.height,
      width: _sc.width,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DDBloc>(
            create: (BuildContext context) => DDBloc(localidadBL: _locBL),
          ),
          BlocProvider<FormLocalidadBloc>(
            create: (BuildContext context) =>
                FormLocalidadBloc(localidadBL: _locBL),
          ),
          BlocProvider<FormVerbenaBloc>(
            create: (BuildContext context) => FormVerbenaBloc(),
          ),
        ],
        child: FormAdmin(),
      ),
    ));
  }
}

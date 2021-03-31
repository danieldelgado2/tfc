import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verbenapp/form/admin.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc({this.localidadBL, this.loc})
      : assert(localidadBL != null),
        super(const FormState.initial());

  final LocalidadBL? localidadBL;
  final Localidad? loc;

  @override
  Stream<FormState> mapEventToState(
    FormEvent event,
  ) async* {
    _mapEventToState(event);
  }

  Stream<FormState> _mapEventToState(FormEvent event) async* {
    if (event is CrearDD) {
      yield const FormState.loading();

      try {
        final locDD = await localidadBL!.localidadesDD();

        yield FormState.crearDD(locDD);
      } on Exception catch (e, stk) {
        print(e);
        print(stk);
      }
    } else if (event is ChangeDD) {
      yield FormState.changeDD(LocalidadForm(event.loc.nombre,
          event.loc.provincia, event.loc.latitud, event.loc.longitud));
    }
  }
}

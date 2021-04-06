import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verbenapp/form/form.dart';

part 'form_localidad_event.dart';
part 'form_localidad_state.dart';

class FormLocalidadBloc extends Bloc<FormLocalidadEvent, FormLocalidadState> {
  FormLocalidadBloc() : super(FormLocalidadState.initial());

  @override
  Stream<FormLocalidadState> mapEventToState(
    FormLocalidadEvent event,
  ) async* {
    if (event is ChangeDD) {
      yield FormLocalidadState.changeDD(event.loc);
    } else if (event is ModificarLocalidad) {
      if (event.data.isNotEmpty) {
        state.locEditar.nombre = event.data;
        yield state;
      }
    } else if (event is ModificarProvincia) {
      if (event.data.isNotEmpty) {
        state.locEditar.provincia = event.data;
        yield state;
      }
    } else if (event is ModificarLatitud) {
      final r = num.tryParse(event.data);
      if (r != null) {
        state.locEditar.latitud = r;
        yield state;
      }
    } else if (event is ModificarLongitud) {
      final r = num.tryParse(event.data);
      if (r != null) {
        state.locEditar.longitud = r;
        yield state;
      }
    } else if (event is AgregarVerbenas) {
      state.locEditar.verbenas.add(event.data);
      yield FormLocalidadState.agregarV(state.locEditar);
    } else if (event is QuitarVerbenas) {
      state.locEditar.verbenas.removeAt(event.data);
      yield FormLocalidadState.quitarV(state.locEditar);
    } else if (event is GuardarLocalidad) {
      // if (state.valid) {
      //   yield FormLocalidadState.insertRegistro(state.locEditar);
      //   final loc = state.locEditar;
      //   final result = await localidadBL.insertarLocalidad(Localidad(
      //       nombre: loc.localidad,
      //       provincia: loc.provincia,
      //       latitud: loc.latitud,
      //       longitud: loc.longitud,
      //       verbenas: loc.verbenas));
      //   yield FormLocalidadState.success();
      // }
    }
  }

  Stream<FormLocalidadState> _mapEventToState(
      FormLocalidadEvent event) async* {}
}

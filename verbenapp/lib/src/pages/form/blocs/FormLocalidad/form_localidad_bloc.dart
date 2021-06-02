import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Verbenapp/src/DAL/models/localidad.dart';

part 'form_localidad_event.dart';
part 'form_localidad_state.dart';

///
/// Bloc encargado de manejar los estados
/// de los inputs relacionados con la localidad
/// que se está editando
///
class FormLocalidadBloc extends Bloc<FormLocalidadEvent, FormLocalidadState> {
  FormLocalidadBloc({this.localidadBL}) : super(FormLocalidadState.initial());

  final localidadBL;

  ///
  /// Dado un evento ocurrido en la UI,
  /// el State cambiará con unas nuevas
  /// propiedades
  ///
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
      final r = double.tryParse(event.data);
      if (r != null) {
        state.locEditar.latitud = r;
        yield FormLocalidadState.changeDD(state.locEditar);
      }
    } else if (event is ModificarLongitud) {
      final r = double.tryParse(event.data);
      if (r != null) {
        state.locEditar.longitud = r;
        yield FormLocalidadState.changeDD(state.locEditar);
      }
    } else if (event is ModificarVerbenas) {
      var verbenas = state.locEditar.verbenas;
      if (event.data.id == "") {
        event.data.id = event.data.nombre;
        verbenas.add(event.data);
      } else {
        var v = verbenas.firstWhere((v) => v.id == event.data.id);
        if (v != null)
          verbenas[verbenas.indexOf(v)] = event.data;
        else
          print("ha salido null");
      }

      yield FormLocalidadState.agregarV(state.locEditar);
    } else if (event is QuitarVerbenas) {
      state.locEditar.verbenas.removeAt(event.data);
      yield FormLocalidadState.quitarV(state.locEditar);
    } else if (event is GuardarLocalidad) {
      yield FormLocalidadState.insertRegistro(event.data);
      if (await localidadBL.insertarLocalidad(event.data) != null) {
        if (event.data.id == "") event.data.id = event.data.nombre;

        yield FormLocalidadState.success(event.data);
      } else
        yield FormLocalidadState.error(state.locEditar);
    }
  }
}

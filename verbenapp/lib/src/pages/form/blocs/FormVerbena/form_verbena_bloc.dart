import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Verbenapp/src/DAL/models/verbena.dart';

part 'form_verbena_event.dart';
part 'form_verbena_state.dart';

///
/// Bloc encargado de manejar los inputs
/// de la verbena nueva/seleccionada
///
class FormVerbenaBloc extends Bloc<FormVerbenaEvent, FormVerbenaState> {
  FormVerbenaBloc() : super(FormVerbenaState.initial());

  /// Dado un evento ocurrido en la UI,
  /// el State cambiará con unas nuevas
  /// propiedades
  ///
  @override
  Stream<FormVerbenaState> mapEventToState(
    FormVerbenaEvent event,
  ) async* {
    if (event is ChangeVerbena) {
      yield FormVerbenaState.modify(event.data);
    } else if (event is NombreV) {
      state.verbena.nombre = event.data;
      yield state;
    } else if (event is DescripcionV) {
      state.verbena.descripcion = event.data;
      yield FormVerbenaState.modify(state.verbena);
    } else if (event is DesdeV) {
      if (event.data.isNotEmpty) {
        state.verbena.desde = event.data;
        yield FormVerbenaState.modify(state.verbena);
      }
    } else if (event is HastaV) {
      if (event.data.isNotEmpty) {
        state.verbena.hasta = event.data;
        yield FormVerbenaState.modify(state.verbena);
      }
      yield state;
    } else if (event is UrlV) {
      state.verbena.url = event.data;
      yield FormVerbenaState.modify(state.verbena);
    } else if (event is UrlTrip) {
      state.verbena.urlTrip = event.data;
      yield FormVerbenaState.modify(state.verbena);
    } else if (event is ImgV) {
      state.verbena.img = event.data;
      yield FormVerbenaState.modify(state.verbena);
    } else if (event is ResetFormVerbena) {
      yield FormVerbenaState.reset();
    }
  }
}

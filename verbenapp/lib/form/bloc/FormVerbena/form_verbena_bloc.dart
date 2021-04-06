import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verbenapp/src2/DAL/models/verbena.dart';

part 'form_verbena_event.dart';
part 'form_verbena_state.dart';

class FormVerbenaBloc extends Bloc<FormVerbenaEvent, FormVerbenaState> {
  FormVerbenaBloc() : super(FormVerbenaState.initial());

  @override
  Stream<FormVerbenaState> mapEventToState(
    FormVerbenaEvent event,
  ) async* {
    if (event is ChangeVerbena) {
      yield state.copyWith(v: event.data);
    } else if (event is NombreV) {
      state.verbena.nombre = event.data;
      yield state;
    } else if (event is DescripcionV) {
      state.verbena.descripcion = event.data;
      yield state;
    } else if (event is DesdeV) {
      if (event.data.isNotEmpty) {
        state.verbena.desde = event.data;
        yield state;
      }
    } else if (event is HastaV) {
      if (event.data.isNotEmpty) {
        state.verbena.hasta = event.data;
        yield state;
      }
      yield state;
    } else if (event is UrlV) {
      state.verbena.url = event.data;
      yield state;
    } else if (event is ImgV) {
      state.verbena.img = event.data;
      yield state;
    } else if (event is ResetFormVerbena) {
      yield FormVerbenaState.initial();
    }
  }
}

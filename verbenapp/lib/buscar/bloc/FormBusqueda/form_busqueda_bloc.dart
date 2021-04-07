import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../buscar.dart';

part 'form_busqueda_event.dart';
part 'form_busqueda_state.dart';

class FormBusquedaBloc extends Bloc<FormBusquedaEvent, FormBusquedaState> {
  FormBusquedaBloc(this.localidadBL) : super(FormBusquedaState.initial());

  final LocalidadBL localidadBL;

  @override
  Stream<FormBusquedaState> mapEventToState(
    FormBusquedaEvent event,
  ) async* {
    if (event is BuscarPorProvincia && !event.celebrandose) {
      yield FormBusquedaState.loading();
      final locs = await localidadBL.fromProvincia(event.provincia.nombre);
      if (locs.isEmpty)
        yield FormBusquedaState.invalid();
      else
        yield FormBusquedaState.success(locs);
    } else if (event is BuscarPorProvincia && event.celebrandose) {
      yield FormBusquedaState.loading();
      final locs = await localidadBL.fromHotProvincia(event.provincia.nombre);
      if (locs.isEmpty)
        yield FormBusquedaState.invalid();
      else
        yield FormBusquedaState.success(locs);
    } else if (event is BuscarPorUbicacion && !event.celebrandose) {
      yield FormBusquedaState.loading();
      final locs = await localidadBL.fromUbicacion(
          event.ubi.latitude, event.ubi.longitude);
      if (locs.isEmpty)
        yield FormBusquedaState.invalid();
      else
        yield FormBusquedaState.success(locs);
    } else if (event is BuscarPorUbicacion && event.celebrandose) {
      yield FormBusquedaState.loading();
      final locs = await localidadBL.fromHotUbicacion(
          event.ubi.latitude, event.ubi.longitude);
      if (locs.isEmpty)
        yield FormBusquedaState.invalid();
      else
        yield FormBusquedaState.success(locs);
    }
  }
}

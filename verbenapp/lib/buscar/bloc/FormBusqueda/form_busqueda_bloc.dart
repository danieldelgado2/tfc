import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../buscar.dart';

part 'form_busqueda_event.dart';
part 'form_busqueda_state.dart';

class FormBusquedaBloc extends Bloc<FormBusquedaEvent, FormBusquedaState> {
  FormBusquedaBloc(this.localidadBL, this.mapaBL)
      : super(FormBusquedaState.initial());

  final LocalidadBL localidadBL;
  final MapaBL mapaBL;
  LocationData location;

  @override
  Stream<FormBusquedaState> mapEventToState(
    FormBusquedaEvent event,
  ) async* {
    if (event is CambiaProvincia) {
      yield FormBusquedaState.changing(
          event.provincia, state.ubicacion, state.localidades);
    } else {
      var locs;
      yield FormBusquedaState.loading(location, state.provincia);

      if (event is BuscarPorProvincia && !event.celebrandose) {
        locs = await localidadBL.fromProvincia(state.provincia.nombre);
      } else if (event is BuscarPorProvincia && event.celebrandose) {
        locs =
            await localidadBL.delMesPorNombreProvincia(state.provincia.nombre);
      } else if (event is BuscarPorUbicacion) {
        if ((location = await mapaBL.getLocation()) == null)
          yield FormBusquedaState.invalid();
        else {
          if (event.celebrandose) {
            locs = await localidadBL.delMesPorUbicacion(
                location.latitude, location.longitude);
          } else {
            locs = await localidadBL.fromUbicacion(
                location.latitude, location.longitude);
          }
        }
      }
      if (locs.isEmpty)
        yield FormBusquedaState.invalid();
      else
        yield FormBusquedaState.success(locs, state.provincia);
    }
  }
}

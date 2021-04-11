import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:latlong/latlong.dart';
import 'package:verbenapp/src/DAL/models/ubicacion.dart';

import '../../buscar.dart';

part 'form_busqueda_event.dart';
part 'form_busqueda_state.dart';

class FormBusquedaBloc extends Bloc<FormBusquedaEvent, FormBusquedaState> {
  FormBusquedaBloc(this.localidadBL, this.mapaBL)
      : super(FormBusquedaState.initial());

  final LocalidadBL localidadBL;
  final MapaBL mapaBL;
  LocationData _location;

  @override
  Stream<FormBusquedaState> mapEventToState(
    FormBusquedaEvent event,
  ) async* {
    if (event is CambiaProvincia) {
      yield FormBusquedaState.porProvincia(event.provincia, state.checkValue);
    } else if (event is PorProvincia) {
      if (event.provincia != null)
        yield FormBusquedaState.porProvincia(state.provincia, state.checkValue);
      else
        yield FormBusquedaState.invalid();
    } else if (event is PorUbicacion) {
      if (_location == null) _location = await mapaBL.getLocation();
      if (_location != null)
        yield FormBusquedaState.porUbicacion(
            Ubicacion(
                coord: LatLng(_location.latitude, _location.longitude),
                localidades: <Localidad>[]),
            state.checkValue);
      else
        yield FormBusquedaState.invalid();
    } else if (event is CambiaCheck) {
      if (state.ubicacion != null)
        yield FormBusquedaState.porUbicacion(state.ubicacion, event.value);
      else if (state.provincia != null)
        yield FormBusquedaState.porProvincia(state.provincia, event.value);
      else
        yield FormBusquedaState.invalid();
    } else {
      switch (state.status) {
        case FormBusquedaStatus.porProvincia:
          if (!state.checkValue)
            state.provincia.localidades =
                await localidadBL.fromProvName(state.provincia.nombre);
          else
            state.provincia.localidades = await localidadBL
                .delMesPorNombreProvincia(state.provincia.nombre);

          if (state.provincia.localidades.isEmpty) {
            yield FormBusquedaState.empty(
                state.checkValue, state.provincia, null);
            break;
          }
          yield FormBusquedaState.porProvincia(
              state.provincia, state.checkValue);
          break;

        case FormBusquedaStatus.porUbicacion:
          if (!state.checkValue)
            state.ubicacion.localidades = await localidadBL.fromUbicacion(
                state.ubicacion.coord.latitude,
                state.ubicacion.coord.longitude);
          else
            state.ubicacion.localidades = await localidadBL.delMesPorUbicacion(
                state.ubicacion.coord.latitude,
                state.ubicacion.coord.longitude);
          if (state.ubicacion.localidades.isEmpty) {
            yield FormBusquedaState.empty(
                state.checkValue, null, state.ubicacion);
            break;
          }
          yield FormBusquedaState.porUbicacion(
              state.ubicacion, state.checkValue);
          break;

        case FormBusquedaStatus.invalid:
          yield FormBusquedaState.invalid();
          break;
      }
    }
  }
}

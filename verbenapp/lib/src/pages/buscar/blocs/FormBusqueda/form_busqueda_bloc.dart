import 'dart:async';

import 'package:bloc/bloc.dart';

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
    final provincia = event.prov;
    final ubicacion = event.ubi;
    final byDelMes = event.byDelMes;
    var locs = <Localidad>[];

    if (provincia != null && byDelMes)
      locs = await localidadBL.delMesPorNombreProvincia(provincia.nombre);
    else if (provincia != null && !byDelMes)
      locs = await localidadBL.fromProvName(provincia.nombre);
    else if (ubicacion != null && byDelMes)
      locs = await localidadBL.delMesPorUbicacion(
          ubicacion.latitude, ubicacion.longitude);
    else if (ubicacion != null && !byDelMes)
      locs = await localidadBL.fromUbicacion(
          ubicacion.latitude, ubicacion.longitude);
    else {
      yield FormBusquedaState.error();
      return;
    }

    if (locs.isEmpty)
      yield FormBusquedaState.empty();
    else
      yield FormBusquedaState.success(locs);
  }
}

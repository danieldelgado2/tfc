import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../bloc.dart';

part 'banner_busqueda_event.dart';
part 'banner_busqueda_state.dart';

class BannerBusquedaBloc
    extends Bloc<BannerBusquedaEvent, BannerBusquedaState> {
  BannerBusquedaBloc({this.mapaBL})
      : super(BannerBusquedaState.invalid(null, null, false));

  final MapaBL mapaBL;

  LocationData _location;
  @override
  Stream<BannerBusquedaState> mapEventToState(
    BannerBusquedaEvent event,
  ) async* {
    if (event is CambiaProvincia) {
      yield BannerBusquedaState.porProvincia(event.provincia, state.byDelMes);
      print(
          'Se ha cambiado la provincia del dropdown a ${event.provincia.nombre}');
    } else if (event is PorProvincia) {
      if (event.provincia != null) {
        yield BannerBusquedaState.porProvincia(state.provincia, state.byDelMes);
        print(
            'Evento por provincia con la provincia ${event.provincia.nombre}');
      } else
        print('Evento por provincia pero la provincia es null');
      // yield BannerBusquedaState.invalid(
      //     state.ubicacion, state.provincia, state.byDelMes);
    } else if (event is PorUbicacion) {
      if (_location == null) _location = await mapaBL.getLocation();
      if (_location != null) {
        print('evento por ubicacion en ${_location.latitude}');
        yield BannerBusquedaState.porUbicacion(_location, state.byDelMes);
      } else {
        print('la app no tiene permisos');
        yield BannerBusquedaState.invalid(
            state.ubicacion, state.provincia, state.byDelMes);
      }
    } else if (event is CambiaCheck) {
      if (state.ubicacion != null)
        yield BannerBusquedaState.porUbicacion(state.ubicacion, event.value);
      else if (state.provincia != null)
        yield BannerBusquedaState.porProvincia(state.provincia, event.value);

      print('check cambiado a ${event.value}');
    }
  }
}

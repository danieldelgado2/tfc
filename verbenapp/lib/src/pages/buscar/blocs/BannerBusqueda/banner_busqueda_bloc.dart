import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../buscar.dart';

part 'banner_busqueda_event.dart';
part 'banner_busqueda_state.dart';

///
/// Bloc encargado de manejar los
/// diferentes criterios del formulario
/// de la vista de Búsqueda
///
class BannerBusquedaBloc
    extends Bloc<BannerBusquedaEvent, BannerBusquedaState> {
  BannerBusquedaBloc({this.mapaBL}) : super(BannerBusquedaState.invalid());

  final MapaBL mapaBL;

  LocationData _location;

  ///
  /// Dado un evento ocurrido en la UI,
  /// el State cambiará con unas nuevas
  /// propiedades
  ///
  @override
  Stream<BannerBusquedaState> mapEventToState(
    BannerBusquedaEvent event,
  ) async* {
    if (event is CambiaProvincia) {
      if (event.provincia != null)
        yield BannerBusquedaState.valid(null, event.provincia, state.byDelMes);
      else
        yield BannerBusquedaState.invalid();
    } else if (event is PorProvincia) {
      if (event.provincia != null)
        yield BannerBusquedaState.valid(null, event.provincia, state.byDelMes);
      else
        yield BannerBusquedaState.invalid();
    } else if (event is PorUbicacion) {
      if (_location == null) _location = await mapaBL.getLocation();
      if (_location != null)
        yield BannerBusquedaState.valid(_location, null, state.byDelMes);
      else
        yield BannerBusquedaState.invalid();
    } else if (event is CambiaCheck) {
      if (state.ubicacion != null)
        yield BannerBusquedaState.valid(state.ubicacion, null, event.value);
      else if (state.provincia != null)
        yield BannerBusquedaState.valid(null, state.provincia, event.value);
      else
        yield BannerBusquedaState.invalid();
    }
  }
}

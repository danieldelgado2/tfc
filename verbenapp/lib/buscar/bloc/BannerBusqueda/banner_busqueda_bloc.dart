import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banner_busqueda_event.dart';
part 'banner_busqueda_state.dart';

class BannerBusquedaBloc
    extends Bloc<BannerBusquedaEvent, BannerBusquedaState> {
  BannerBusquedaBloc() : super(BannerBusquedaState.initial());

  @override
  Stream<BannerBusquedaState> mapEventToState(
    BannerBusquedaEvent event,
  ) async* {
    if (event is PorProvincia && event.provinciaSelec != null) {
      yield BannerBusquedaState.porProvincia(
          event.celebrandose == null ?? state.celebrandose,
          event.provinciaSelec);
    } else if (event is PorUbicacion && event.ubicacion != null) {
      yield BannerBusquedaState.porUbicacion(
          event.celebrandose, event.ubicacion);
    } else {
      yield BannerBusquedaState.invalid();
    }
  }
}

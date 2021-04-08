import 'dart:async';

import 'package:bloc/bloc.dart';

part 'banner_busqueda_event.dart';
part 'banner_busqueda_state.dart';

class BannerBusquedaBloc
    extends Bloc<BannerBusquedaEvent, BannerBusquedaState> {
  BannerBusquedaBloc() : super(BannerBusquedaState.initial());

  @override
  Stream<BannerBusquedaState> mapEventToState(
    BannerBusquedaEvent event,
  ) async* {
    if (event is CambiaCheck) {
      if (state.status == BannerBusquedaStatus.porProvincia) {
        yield BannerBusquedaState.porProvincia(event.celebrandose);
      } else {
        yield BannerBusquedaState.porUbicacion(event.celebrandose);
      }
    }
  }
}

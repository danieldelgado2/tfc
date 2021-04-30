import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banner_visible_event.dart';
part 'banner_visible_state.dart';

///
/// Bloc encargado de visibilizar/invisibilizar
/// el formulario de la vista de Busqueda
///
class BannerVisibleBloc extends Bloc<BannerVisibleEvent, BannerVisibleState> {
  BannerVisibleBloc() : super(BannerVisibleState.visible());

  ///
  /// Dado un evento ocurrido en la UI,
  /// el State cambiará con unas nuevas
  /// propiedades
  ///
  @override
  Stream<BannerVisibleState> mapEventToState(
    BannerVisibleEvent event,
  ) async* {
    if (event.data)
      yield BannerVisibleState.visible();
    else
      yield BannerVisibleState.invisible();
  }
}

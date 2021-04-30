import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'localidad_seleccionada_event.dart';
part 'localidad_seleccionada_state.dart';

/// Bloc encargado de manejar los estados
/// de la localidad seleccionada en el mapa
/// de la vista de Búsqueda
class LocalidadSeleccionadaBloc
    extends Bloc<LocalidadSeleccionadaEvent, LocalidadSeleccionadaState> {
  LocalidadSeleccionadaBloc() : super(LocalidadSeleccionadaState.initial());

  /// Bloc encargado de manejar los estados
  /// del Mapa y sus marcadores en función
  /// de los resultados de BD
  @override
  Stream<LocalidadSeleccionadaState> mapEventToState(
    LocalidadSeleccionadaEvent event,
  ) async* {
    if (event is ChangeLoc) {
      yield LocalidadSeleccionadaState.selected(event.data);
    } else {
      yield LocalidadSeleccionadaState.initial();
    }
  }
}

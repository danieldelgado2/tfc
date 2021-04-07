import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'localidad_seleccionada_event.dart';
part 'localidad_seleccionada_state.dart';

class LocalidadSeleccionadaBloc
    extends Bloc<LocalidadSeleccionadaEvent, LocalidadSeleccionadaState> {
  LocalidadSeleccionadaBloc() : super(LocalidadSeleccionadaState.initial());

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

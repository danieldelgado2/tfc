import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verbenapp/form/form.dart';

part 'dd_event.dart';
part 'dd_state.dart';

///
/// Bloc encargado de manejar los estados
/// del DropDown del formulario
///
class DDBloc extends Bloc<DDEvent, DDState> {
  DDBloc({this.localidadBL})
      : assert(localidadBL != null),
        super(const DDState.initial());

  final LocalidadBL localidadBL;

  ///
  /// Dado un evento ocurrido en la UI,
  /// el State cambiará con unas nuevas
  /// propiedades
  ///
  @override
  Stream<DDState> mapEventToState(
    DDEvent event,
  ) async* {
    if (event is CrearDD) {
      final results = await localidadBL.localidadesDD();
      yield state.copyWith(locs: results, st: DDStatus.success);
    }
  }
}

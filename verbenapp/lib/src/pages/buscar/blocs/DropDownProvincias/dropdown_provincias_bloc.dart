import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Verbenapp/src/BL/bl.dart';

part 'dropdown_provincias_event.dart';
part 'dropdown_provincias_state.dart';

///
/// Bloc encargado de manejar los estados
/// del DropDown de Localidad del formulario de la vista
/// de Busqueda
///
class DropDownProvinciasBloc
    extends Bloc<DropDownProvinciasEvent, DropDownProvinciasState> {
  DropDownProvinciasBloc({this.provinciaBL})
      : super(const DropDownProvinciasState.initial());

  final ProvinciaBL provinciaBL;

  ///
  /// Dado un evento ocurrido en la UI,
  /// el State cambiará con unas nuevas
  /// propiedades
  ///
  @override
  Stream<DropDownProvinciasState> mapEventToState(
    DropDownProvinciasEvent event,
  ) async* {
    yield DropDownProvinciasState.success(
        await provinciaBL.provinciasParaSelect());
  }
}

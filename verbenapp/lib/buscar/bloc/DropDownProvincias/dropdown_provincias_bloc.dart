import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verbenapp/src2/BL/bl.dart';

part 'dropdown_provincias_event.dart';
part 'dropdown_provincias_state.dart';

class DropDownProvinciasBloc
    extends Bloc<DropDownProvinciasEvent, DropDownProvinciasState> {
  DropDownProvinciasBloc({this.provinciaBL})
      : super(const DropDownProvinciasState.initial());

  final ProvinciaBL provinciaBL;
  @override
  Stream<DropDownProvinciasState> mapEventToState(
    DropDownProvinciasEvent event,
  ) async* {
    yield DropDownProvinciasState.success(
        await provinciaBL.provinciasParaSelect());
  }
}

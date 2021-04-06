import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verbenapp/form/form.dart';

part 'dd_event.dart';
part 'dd_state.dart';

class DDBloc extends Bloc<DDEvent, DDState> {
  DDBloc({this.localidadBL})
      : assert(localidadBL != null),
        super(const DDState.initial());

  final LocalidadBL localidadBL;
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

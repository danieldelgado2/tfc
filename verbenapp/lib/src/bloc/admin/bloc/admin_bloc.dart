import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verbenapp/src/models/localidad.dart';
import 'package:verbenapp/src/providers/localidad_provider.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc(this._provider)
      : assert(_provider != null),
        super(AdminState.initial());

  final LocalidadProvider _provider;

  @override
  Stream<AdminState> mapEventToState(
    AdminEvent event,
  ) async* {
    if (event is LocalidadChanged) {
      yield const AdminState.loading();

      try {
        final results = await _provider.insertarLocalidad(event.loc);
        yield AdminState.success(results);
      } on Exception catch (e, i) {
        print(i);
        yield const AdminState.failure();
      }
    }
  }
}

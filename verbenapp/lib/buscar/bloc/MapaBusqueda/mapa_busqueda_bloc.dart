import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

part 'mapa_busqueda_event.dart';
part 'mapa_busqueda_state.dart';

class MapaBusquedaBloc extends Bloc<MapaBusquedaEvent, MapaBusquedaState> {
  MapaBusquedaBloc() : super(MapaBusquedaState.empty());

  @override
  Stream<MapaBusquedaState> mapEventToState(
    MapaBusquedaEvent event,
  ) async* {
    if (event.localidades.isEmpty) {
      yield MapaBusquedaState.empty();
    } else {
      final marcadores = [];

      yield MapaBusquedaState.success(marcadores);
    }
  }
}

part of 'mapa_busqueda_bloc.dart';

enum MapaBusquedaStatus { empty, success }

class MapaBusquedaState extends Equatable {
  const MapaBusquedaState._(
      {this.marcadores, this.status = MapaBusquedaStatus.empty});
  MapaBusquedaState.empty() : this._();
  MapaBusquedaState.success(markers)
      : this._(marcadores: markers, status: MapaBusquedaStatus.success);
  // MapaBusquedaState.moveMap(ubi,options,controller)
  //     : this._(
  //           mapController: MapController(),
  //           mapOptions: MapOptions(center: LatLng(0.0, 0.0), zoom: 8));

  final marcadores;
  final status;
  @override
  List<Object> get props => [marcadores];
}

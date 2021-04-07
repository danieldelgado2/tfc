part of 'mapa_busqueda_bloc.dart';

class MapaBusquedaEvent extends Equatable {
  const MapaBusquedaEvent({this.localidades});
  final localidades;
  @override
  List<Object> get props => [localidades];
}

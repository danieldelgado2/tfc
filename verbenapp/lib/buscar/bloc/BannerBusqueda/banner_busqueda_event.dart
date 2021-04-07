part of 'banner_busqueda_bloc.dart';

abstract class BannerBusquedaEvent extends Equatable {
  const BannerBusquedaEvent();

  @override
  List<Object> get props => [];
}

class PorProvincia extends BannerBusquedaEvent {
  const PorProvincia({this.celebrandose, this.provinciaSelec});
  final celebrandose;
  final provinciaSelec;
  List<Object> get props => [celebrandose, provinciaSelec];
}

class PorUbicacion extends BannerBusquedaEvent {
  const PorUbicacion({this.celebrandose, this.ubicacion});
  final celebrandose;
  final ubicacion;
  List<Object> get props => [celebrandose, ubicacion];
}

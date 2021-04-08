part of 'banner_busqueda_bloc.dart';

abstract class BannerBusquedaEvent {
  const BannerBusquedaEvent();

  List<Object> get props => [];
}

class PorProvincia extends BannerBusquedaEvent {
  const PorProvincia({this.celebrandose});
  final celebrandose;
  @override
  List<Object> get props => [celebrandose];
}

class PorUbicacion extends BannerBusquedaEvent {
  const PorUbicacion({this.celebrandose});
  final celebrandose;
  @override
  List<Object> get props => [celebrandose];
}

class CambiaCheck extends BannerBusquedaEvent {
  const CambiaCheck({this.celebrandose});
  final celebrandose;
  @override
  List<Object> get props => [celebrandose];
}

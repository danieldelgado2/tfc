part of 'banner_busqueda_bloc.dart';

///
/// Clase Abstract de tipo Event
/// con la que nuestra UI interactua
/// y que el Bloc se encargará de revisar
/// y cambiar a un State determinado
///
abstract class BannerBusquedaEvent extends Equatable {
  const BannerBusquedaEvent();

  @override
  List<Object> get props => [];
}

///
/// Evento para indicar
/// que se busca por Provincia
///
class PorProvincia extends BannerBusquedaEvent {
  PorProvincia({this.provincia});
  final provincia;
  @override
  List<Object> get props => [provincia];
}

///
/// Evento para indicar
/// que se busca por Ubicación
///
class PorUbicacion extends BannerBusquedaEvent {
  PorUbicacion({this.ubicacion});
  final ubicacion;
  @override
  List<Object> get props => [ubicacion];
}

///
/// Evento para indicar
/// que si se quieren las localidades
/// con que tengan fiestas próximamente
///
class CambiaCheck extends BannerBusquedaEvent {
  const CambiaCheck({this.value});
  final value;

  @override
  List<Object> get props => [value];
}

///
/// Evento para indicar
/// que se ha cambiado la Provincia
/// del DropDown
///
class CambiaProvincia extends BannerBusquedaEvent {
  const CambiaProvincia({this.provincia});
  final provincia;
  @override
  List<Object> get props => [provincia];
}

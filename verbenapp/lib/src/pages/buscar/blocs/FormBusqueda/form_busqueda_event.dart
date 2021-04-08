part of 'form_busqueda_bloc.dart';

abstract class FormBusquedaEvent {
  const FormBusquedaEvent();

  List<Object> get props => [];
}

class BuscarPorProvincia extends FormBusquedaEvent {
  const BuscarPorProvincia({this.celebrandose});
  final celebrandose;
  @override
  List<Object> get props => [celebrandose];
}

class BuscarPorUbicacion extends FormBusquedaEvent {
  const BuscarPorUbicacion({this.celebrandose});
  final celebrandose;
  @override
  List<Object> get props => [celebrandose];
}

class CambiaProvincia extends FormBusquedaEvent {
  const CambiaProvincia({this.provincia});
  final provincia;
  @override
  List<Object> get props => [provincia];
}

part of 'form_busqueda_bloc.dart';

abstract class FormBusquedaEvent {
  const FormBusquedaEvent();

  List<Object> get props => [];
}

class BuscarPorProvincia extends FormBusquedaEvent {
  const BuscarPorProvincia({this.provincia, this.celebrandose});
  final provincia;
  final celebrandose;
  @override
  List<Object> get props => [provincia, celebrandose];
}

class BuscarPorUbicacion extends FormBusquedaEvent {
  const BuscarPorUbicacion({this.ubi, this.celebrandose});
  final ubi;
  final celebrandose;
  @override
  List<Object> get props => [ubi, celebrandose];
}

class Buscar extends FormBusquedaEvent {
  const Buscar();
}

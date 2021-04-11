part of 'form_busqueda_bloc.dart';

abstract class FormBusquedaEvent {
  const FormBusquedaEvent();

  List<Object> get props => [];
}

class PorProvincia extends FormBusquedaEvent {
  PorProvincia({this.provincia});
  final provincia;
  @override
  List<Object> get props => [provincia];
}

class PorUbicacion extends FormBusquedaEvent {}

class CambiaCheck extends FormBusquedaEvent {
  const CambiaCheck({this.value});
  final value;

  @override
  List<Object> get props => [value];
}

class CambiaProvincia extends FormBusquedaEvent {
  const CambiaProvincia({this.provincia});
  final provincia;
  @override
  List<Object> get props => [provincia];
}

class Buscar extends FormBusquedaEvent {}

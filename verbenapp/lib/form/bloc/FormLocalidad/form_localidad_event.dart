part of 'form_localidad_bloc.dart';

abstract class FormLocalidadEvent extends Equatable {
  const FormLocalidadEvent();

  @override
  List<Object> get props => [];
}

class GuardarLocalidad extends FormLocalidadEvent {}

class ModificarLocalidad extends FormLocalidadEvent {
  const ModificarLocalidad(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

class ModificarProvincia extends FormLocalidadEvent {
  const ModificarProvincia(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

class ModificarLatitud extends FormLocalidadEvent {
  const ModificarLatitud(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

class ModificarLongitud extends FormLocalidadEvent {
  const ModificarLongitud(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

class AgregarVerbenas extends FormLocalidadEvent {
  const AgregarVerbenas(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

class QuitarVerbenas extends FormLocalidadEvent {
  const QuitarVerbenas(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

class ChangeDD extends FormLocalidadEvent {
  const ChangeDD(this.loc);
  final Localidad loc;

  @override
  List<Object> get props => [loc];
}

class ResetFormLocalidad extends FormLocalidadEvent {
  const ResetFormLocalidad();
}

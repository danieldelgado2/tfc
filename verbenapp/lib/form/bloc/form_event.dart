part of 'form_bloc.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class GuardarLocalidad extends FormEvent {
  const GuardarLocalidad(this.localidad);
  final LocalidadForm localidad;

  @override
  List<Object> get props => [localidad];
}

class ModificarLocalidad extends FormEvent {
  const ModificarLocalidad(this.localidad);
  final LocalidadForm localidad;

  @override
  List<Object> get props => [localidad];
}

class ModificarLatitud extends FormEvent {
  const ModificarLatitud(this.localidad);
  final LocalidadForm localidad;

  @override
  List<Object> get props => [localidad];
}

class CrearDD extends FormEvent {
  const CrearDD(this.localidades);
  final localidades;

  @override
  List<Object> get props => [localidades];
}

class ChangeDD extends FormEvent {
  const ChangeDD(this.loc);
  final Localidad loc;

  @override
  List<Object> get props => [loc];
}

part of 'form_localidad_bloc.dart';

enum FormLocalidadStatus {
  initial,
  loading,
  success,
  quitarV,
  agregarV,
  changeDD
}

///
/// Clase de tipo State, a la que
/// reaccionará la UI gracias a los
/// BlocBuilders o BlocListeners.
///
/// Disponer de varios constructores
/// dependiendo de las propiedades del
/// estado concreto al que va a pasar
///
///
class FormLocalidadState {
  FormLocalidadState._(
      {this.locEditar,
      this.status = FormLocalidadStatus.initial,
      this.valid = false});

  // Estado inicial del formulario
  FormLocalidadState.initial() : this._(locEditar: Localidad(verbenas: []));

  // Estado al cambiar el DropDown del formulario
  FormLocalidadState.changeDD(loc)
      : this._(
            locEditar: loc, valid: false, status: FormLocalidadStatus.changeDD);

  // Estado al cambiar quitar una verbena
  FormLocalidadState.quitarV(loc)
      : this._(
            locEditar: loc, valid: false, status: FormLocalidadStatus.quitarV);

  // Estado al cambiar agregar una verbena
  FormLocalidadState.agregarV(loc)
      : this._(
            locEditar: loc, valid: false, status: FormLocalidadStatus.agregarV);

  // Estado al guardar la localidad
  FormLocalidadState.insertRegistro(Localidad loc)
      : this._(locEditar: loc, status: FormLocalidadStatus.loading);

  // Estado al tener una insercción correcta en BD
  FormLocalidadState.success()
      : this._(
            status: FormLocalidadStatus.success,
            locEditar: Localidad(verbenas: []));

  final status;
  final locEditar;
  final valid;

  List<Object> get props => [locEditar, status, valid];
}

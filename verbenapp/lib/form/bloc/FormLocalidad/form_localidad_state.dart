part of 'form_localidad_bloc.dart';

enum FormLocalidadStatus {
  initial,
  loading,
  // success,
  quitarV,
  agregarV,
  changeDD
}

class FormLocalidadState {
  FormLocalidadState._(
      {this.locEditar,
      this.status = FormLocalidadStatus.initial,
      this.valid = false});

  FormLocalidadState.initial() : this._(locEditar: Localidad(verbenas: []));
  FormLocalidadState.changeDD(loc)
      : this._(
            locEditar: loc, valid: false, status: FormLocalidadStatus.changeDD);
  FormLocalidadState.quitarV(loc)
      : this._(
            locEditar: loc, valid: false, status: FormLocalidadStatus.quitarV);
  FormLocalidadState.agregarV(loc)
      : this._(
            locEditar: loc, valid: false, status: FormLocalidadStatus.agregarV);

  FormLocalidadState.insertRegistro(Localidad loc)
      : this._(locEditar: loc, status: FormLocalidadStatus.loading);
  FormLocalidadState.validar(bool v) : this._(valid: v);

  //  FormLocalidadState.success() : this._(status: FormLocalidadStatus.success);

  final status;
  final locEditar;
  final valid;

  List<Object> get props => [locEditar, status, valid];
}

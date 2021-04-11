part of 'form_busqueda_bloc.dart';

enum FormBusquedaStatus { empty, porProvincia, porUbicacion, invalid }

class FormBusquedaState {
  const FormBusquedaState._(
      {this.status = FormBusquedaStatus.invalid,
      this.provincia,
      this.ubicacion,
      this.checkValue = false});

  const FormBusquedaState.initial() : this._();

  const FormBusquedaState.porProvincia(prov, value)
      : this._(
          status: FormBusquedaStatus.porProvincia,
          provincia: prov,
          checkValue: value,
        );
  const FormBusquedaState.porUbicacion(ubi, value)
      : this._(
          status: FormBusquedaStatus.porUbicacion,
          ubicacion: ubi,
          checkValue: value,
        );

  const FormBusquedaState.empty(value, prov, ubi)
      : this._(
            status: FormBusquedaStatus.empty,
            provincia: prov,
            ubicacion: ubi,
            checkValue: value);
  const FormBusquedaState.invalid()
      : this._(
          status: FormBusquedaStatus.invalid,
        );

  final status;
  final provincia;
  final ubicacion;
  final checkValue;

  List<Object> get props => [status, provincia, ubicacion, checkValue];
}

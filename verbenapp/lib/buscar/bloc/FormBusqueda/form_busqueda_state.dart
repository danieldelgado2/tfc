part of 'form_busqueda_bloc.dart';

enum FormBusquedaStatus { initial, loading, success, empty, changing }

class FormBusquedaState {
  const FormBusquedaState._(
      {this.status = FormBusquedaStatus.initial,
      this.localidades = const <Localidad>[],
      this.provincia,
      this.ubicacion});

  const FormBusquedaState.initial() : this._();

  const FormBusquedaState.loading(ubi, prov)
      : this._(
          status: FormBusquedaStatus.loading,
          provincia: prov,
          ubicacion: ubi,
        );
  const FormBusquedaState.success(locs, prov)
      : this._(
            status: FormBusquedaStatus.success,
            localidades: locs,
            provincia: prov);
  const FormBusquedaState.invalid()
      : this._(
          status: FormBusquedaStatus.empty,
        );
  const FormBusquedaState.changing(prov, ubi, locs)
      : this._(
            status: FormBusquedaStatus.changing,
            provincia: prov,
            ubicacion: ubi,
            localidades: locs);

  final status;
  final List<Localidad> localidades;
  final provincia;
  final ubicacion;

  List<Object> get props => [status, provincia, ubicacion, localidades];
}

part of 'form_busqueda_bloc.dart';

enum FormBusquedaStatus { initial, loading, success, empty }

class FormBusquedaState {
  const FormBusquedaState._({
    this.status = FormBusquedaStatus.initial,
    this.localidades = const <Localidad>[],
  });

  const FormBusquedaState.initial() : this._();

  const FormBusquedaState.loading()
      : this._(status: FormBusquedaStatus.loading);
  const FormBusquedaState.success(locs)
      : this._(
          status: FormBusquedaStatus.success,
          localidades: locs,
        );
  const FormBusquedaState.invalid()
      : this._(
          status: FormBusquedaStatus.empty,
        );

  final status;
  final localidades;

  List<Object> get props => [status, localidades];
}

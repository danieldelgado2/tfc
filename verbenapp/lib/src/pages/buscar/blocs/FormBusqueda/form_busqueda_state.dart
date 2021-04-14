part of 'form_busqueda_bloc.dart';

enum FormBusquedaStatus { empty, sucess, initial, error }

class FormBusquedaState {
  const FormBusquedaState._({
    this.status = FormBusquedaStatus.initial,
    this.locs = const <Localidad>[],
  });

  const FormBusquedaState.initial() : this._();

  const FormBusquedaState.empty()
      : this._(status: FormBusquedaStatus.empty, locs: const <Localidad>[]);

  const FormBusquedaState.success(localidades)
      : this._(status: FormBusquedaStatus.sucess, locs: localidades);
  const FormBusquedaState.error()
      : this._(status: FormBusquedaStatus.error, locs: const <Localidad>[]);

  final status;
  final locs;

  List<Object> get props => [status, locs];
}

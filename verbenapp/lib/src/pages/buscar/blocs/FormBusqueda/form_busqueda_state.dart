part of 'form_busqueda_bloc.dart';

enum FormBusquedaStatus { empty, sucess, initial, error }

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

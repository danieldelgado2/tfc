part of 'form_verbena_bloc.dart';

///
/// Clase de tipo State, a la que
/// reaccionará la UI gracias a los
/// BlocBuilders o BlocListeners.
///
enum FormVerbenaStatus {
  initial,
  newVerbena,
  editing,
}

/// Disponer de varios constructores
/// dependiendo de las propiedades del
/// estado concreto al que va a pasar
///
///
class FormVerbenaState {
  FormVerbenaState._({this.verbena, this.status});

  // Estado inicial del formulario
  FormVerbenaState.initial()
      : this._(verbena: Verbena(), status: FormVerbenaStatus.initial);

  final verbena;
  final status;

  FormVerbenaState.modify(v)
      : this._(verbena: v, status: FormVerbenaStatus.editing);

  FormVerbenaState.reset()
      : this._(verbena: Verbena(), status: FormVerbenaStatus.newVerbena);

  List<Object> get props => [verbena, status];
}

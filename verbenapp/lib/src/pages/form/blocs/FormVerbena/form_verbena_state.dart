part of 'form_verbena_bloc.dart';

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
class FormVerbenaState extends Equatable {
  FormVerbenaState._({this.verbena});

  // Estado inicial del formulario
  FormVerbenaState.initial() : this._(verbena: Verbena());

  final verbena;

  FormVerbenaState copyWith({Verbena v}) {
    return FormVerbenaState._(verbena: v);
  }

  @override
  List<Object> get props => [verbena];
}

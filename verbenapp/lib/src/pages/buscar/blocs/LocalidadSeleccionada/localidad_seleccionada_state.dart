part of 'localidad_seleccionada_bloc.dart';

enum LocalidadSeleccionadaStatus {
  initial,
  selected,
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
class LocalidadSeleccionadaState extends Equatable {
  const LocalidadSeleccionadaState._(
      {this.localidad, this.status = LocalidadSeleccionadaStatus.initial});

  const LocalidadSeleccionadaState.initial() : this._();
  const LocalidadSeleccionadaState.selected(loc)
      : this._(status: LocalidadSeleccionadaStatus.selected, localidad: loc);

  final localidad;
  final status;
  @override
  List<Object> get props => [localidad];
}

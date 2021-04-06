part of 'dd_bloc.dart';

enum DDStatus { initial, success }

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
class DDState extends Equatable {
  const DDState._({
    this.status = DDStatus.initial,
    this.localidadesDD = const <Localidad>[],
  });

  // Estado inicial del DropDown
  const DDState.initial() : this._();

  DDState copyWith({List<Localidad> locs, DDStatus st}) {
    return DDState._(localidadesDD: locs, status: st);
  }

  final List<Localidad> localidadesDD;
  final DDStatus status;
  @override
  List<Object> get props => [localidadesDD, status];
}

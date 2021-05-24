part of 'localidad_seleccionada_bloc.dart';

///
/// Clase Abstract de tipo Event
/// con la que nuestra UI interactua
/// y que el Bloc se encargará de revisar
/// y cambiar a un State determinado
///
abstract class LocalidadSeleccionadaEvent extends Equatable {
  const LocalidadSeleccionadaEvent();

  @override
  List<Object> get props => [];
}

///
/// Evento para indicar
/// que se ha seleccionado Localidad
/// en el mapa
///
class ChangeLoc extends LocalidadSeleccionadaEvent {
  const ChangeLoc({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para resetear la
/// Localidad seleccionada en el mapa
///
class ResetLoc extends LocalidadSeleccionadaEvent {
  const ResetLoc();
}

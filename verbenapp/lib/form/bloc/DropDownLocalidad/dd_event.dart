part of 'dd_bloc.dart';

///
/// Clase Abstract de tipo Event
/// con la que nuestra UI interactua
/// y que el Bloc se encargará de revisar
/// y cambiar a un State determinado
///
abstract class DDEvent extends Equatable {
  const DDEvent();

  @override
  List<Object> get props => [];
}

///
/// Evento para inicializar
/// el DropDown
///
class CrearDD extends DDEvent {
  const CrearDD();
}

part of 'form_verbena_bloc.dart';

///
/// Clase Abstract de tipo Event
/// con la que nuestra UI interactua
/// y que el Bloc se encargará de revisar
/// y cambiar a un State determinado
///
abstract class FormVerbenaEvent extends Equatable {
  const FormVerbenaEvent();

  @override
  List<Object> get props => [];
}

///
/// Evento para modificar el nombre de
/// la verbena
///
class NombreV extends FormVerbenaEvent {
  const NombreV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para modificar la descripcion
/// de la verbena
///
class DescripcionV extends FormVerbenaEvent {
  const DescripcionV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

//
/// Evento para modificar la fecha desde
///
class DesdeV extends FormVerbenaEvent {
  const DesdeV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para modificar la fecha hasta
///
class HastaV extends FormVerbenaEvent {
  const HastaV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para modificar la img
///
class ImgV extends FormVerbenaEvent {
  const ImgV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para modificar la url
///
class UrlV extends FormVerbenaEvent {
  const UrlV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para coger los datos de la verbena
/// seleccionada
///
class ChangeVerbena extends FormVerbenaEvent {
  const ChangeVerbena({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para limpiar el formulario de verbena
///
class ResetFormVerbena extends FormVerbenaEvent {
  const ResetFormVerbena();
}

part of 'form_localidad_bloc.dart';

///
/// Clase Abstract de tipo Event
/// con la que nuestra UI interactua
/// y que el Bloc se encargará de revisar
/// y cambiar a un State determinado
///
abstract class FormLocalidadEvent {
  const FormLocalidadEvent();

  List<Object> get props => [];
}

///
/// Evento para guardar
/// la Localidad
///
class GuardarLocalidad extends FormLocalidadEvent {
  const GuardarLocalidad(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para modificar el nombre de
/// la Localidad
///
class ModificarLocalidad extends FormLocalidadEvent {
  const ModificarLocalidad(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para modificar la provincia de
/// la Localidad
///
class ModificarProvincia extends FormLocalidadEvent {
  const ModificarProvincia(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para modificar la latitud de
/// la Localidad
///
class ModificarLatitud extends FormLocalidadEvent {
  const ModificarLatitud(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para modificar la longitud de
/// la Localidad
///
class ModificarLongitud extends FormLocalidadEvent {
  const ModificarLongitud(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para agregar verbenas a la Localidad
///
class ModificarVerbenas extends FormLocalidadEvent {
  const ModificarVerbenas(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para quitar verbenas a la Localidad
///
class QuitarVerbenas extends FormLocalidadEvent {
  const QuitarVerbenas(this.data);
  final data;

  @override
  List<Object> get props => [data];
}

///
/// Evento para cambiar los datos del
/// formulario con la localidad que
/// se acaba de seleccionar en el DropDown
///
class ChangeDD extends FormLocalidadEvent {
  const ChangeDD(this.loc);
  final loc;

  @override
  List<Object> get props => [loc];
}

///
/// Evento limpiar el formulario
///
class ResetFormLocalidad extends FormLocalidadEvent {
  const ResetFormLocalidad();
}

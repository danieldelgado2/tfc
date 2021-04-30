part of 'form_busqueda_bloc.dart';

///
/// Evento para buscar en BD con
/// determinados criterios según
/// el formulario de Búsqueda
///
class FormBusquedaEvent {
  const FormBusquedaEvent({this.ubi, this.prov, this.byDelMes});
  final ubi;
  final prov;
  final byDelMes;
  List<Object> get props => [ubi, prov, byDelMes];
}

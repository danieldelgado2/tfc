part of 'form_busqueda_bloc.dart';

class FormBusquedaEvent {
  const FormBusquedaEvent({this.ubi, this.prov, this.byDelMes});
  final ubi;
  final prov;
  final byDelMes;
  List<Object> get props => [ubi, prov, byDelMes];
}

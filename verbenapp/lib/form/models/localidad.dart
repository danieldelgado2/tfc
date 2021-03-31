import 'package:equatable/equatable.dart';

class LocalidadForm extends Equatable {
  const LocalidadForm(
      this.localidad, this.provincia, this.latitud, this.longitud);
  final String localidad;
  final String provincia;
  final double latitud;
  final double longitud;

  @override
  List<Object> get props => [localidad, provincia, latitud, longitud];
}

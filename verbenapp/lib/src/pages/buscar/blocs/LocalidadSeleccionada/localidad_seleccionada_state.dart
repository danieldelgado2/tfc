part of 'localidad_seleccionada_bloc.dart';

enum LocalidadSeleccionadaStatus {
  initial,
  selected,
}

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

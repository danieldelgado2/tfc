part of 'localidad_seleccionada_bloc.dart';

abstract class LocalidadSeleccionadaEvent extends Equatable {
  const LocalidadSeleccionadaEvent();

  @override
  List<Object> get props => [];
}

class ChangeLoc extends LocalidadSeleccionadaEvent {
  const ChangeLoc({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

class ResetLoc extends LocalidadSeleccionadaEvent {
  const ResetLoc();
}

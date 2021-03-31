part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class LocalidadChanged extends AdminEvent {
  const LocalidadChanged(this.loc);
  final Localidad loc;
  @override
  List<Object> get props => [loc];
}

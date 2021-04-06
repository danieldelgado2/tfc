part of 'dd_bloc.dart';

abstract class DDEvent extends Equatable {
  const DDEvent();

  @override
  List<Object> get props => [];
}

class CrearDD extends DDEvent {
  const CrearDD();
}

part of 'verbenas_bloc.dart';

abstract class VerbenasEvent extends Equatable {
  const VerbenasEvent();

  @override
  List<Object> get props => [];
}

class ChangeVerbenas extends VerbenasEvent {
  const ChangeVerbenas({this.vbs});

  final vbs;

  @override
  List<Object> get props => [vbs];
}

class AgregarVerbenasListView extends VerbenasEvent {
  const AgregarVerbenasListView({this.vbna});

  final vbna;

  @override
  List<Object> get props => [vbna];
}

class QuitarVerbenasListView extends VerbenasEvent {
  const QuitarVerbenasListView({this.vbna});

  final vbna;

  @override
  List<Object> get props => [vbna];
}

part of 'form_verbena_bloc.dart';

abstract class FormVerbenaEvent extends Equatable {
  const FormVerbenaEvent();

  @override
  List<Object> get props => [];
}

class NombreV extends FormVerbenaEvent {
  const NombreV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

class DescripcionV extends FormVerbenaEvent {
  const DescripcionV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

class DesdeV extends FormVerbenaEvent {
  const DesdeV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

class HastaV extends FormVerbenaEvent {
  const HastaV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

class ImgV extends FormVerbenaEvent {
  const ImgV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

class UrlV extends FormVerbenaEvent {
  const UrlV({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

class ChangeVerbena extends FormVerbenaEvent {
  const ChangeVerbena({this.data});

  final data;

  @override
  List<Object> get props => [data];
}

class ResetFormVerbena extends FormVerbenaEvent {
  const ResetFormVerbena();
}

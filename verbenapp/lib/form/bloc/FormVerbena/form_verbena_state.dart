part of 'form_verbena_bloc.dart';

class FormVerbenaState extends Equatable {
  FormVerbenaState._({this.verbena});

  FormVerbenaState.initial() : this._(verbena: Verbena());

  final verbena;

  FormVerbenaState copyWith({Verbena v}) {
    return FormVerbenaState._(verbena: v);
  }

  @override
  List<Object> get props => [verbena];
}

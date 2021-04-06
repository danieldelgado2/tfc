part of 'dd_bloc.dart';

enum DDStatus { initial, success }

class DDState extends Equatable {
  const DDState._({
    this.status = DDStatus.initial,
    this.localidadesDD = const <Localidad>[],
  });

  const DDState.initial() : this._();

  DDState copyWith({List<Localidad> locs, DDStatus st}) {
    return DDState._(localidadesDD: locs, status: st);
  }

  final List<Localidad> localidadesDD;
  final DDStatus status;
  @override
  List<Object> get props => [localidadesDD, status];
}

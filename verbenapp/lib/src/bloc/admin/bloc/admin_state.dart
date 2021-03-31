part of 'admin_bloc.dart';

enum AdminStatus { initial, loading, success, failure }

class AdminState extends Equatable {
  const AdminState._({
    this.status = AdminStatus.initial,
    this.localidad = const <Localidad>[],
    this.done = false,
  });

  const AdminState.initial() : this._();
  const AdminState.loading() : this._(status: AdminStatus.loading);
  const AdminState.success(bool _done)
      : this._(status: AdminStatus.success, done: _done);
  const AdminState.failure() : this._(status: AdminStatus.failure);

  final AdminStatus status;
  final List<Localidad> localidad;
  final bool done;
  @override
  // TODO: implement props
  List<Object> get props => [status, localidad, done];
}

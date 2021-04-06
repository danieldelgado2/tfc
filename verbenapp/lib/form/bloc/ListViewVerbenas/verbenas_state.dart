part of 'verbenas_bloc.dart';

enum VerbenasStatus { initial, change }

class VerbenasState extends Equatable {
  VerbenasState._({this.verbenas, this.status = VerbenasStatus.initial});

  VerbenasState.initial() : this._();
  VerbenasState.change(List<Verbena> vbs)
      : this._(verbenas: vbs, status: VerbenasStatus.change);

  final List<Verbena> verbenas;
  final VerbenasStatus status;
  @override
  List<Object> get props => [verbenas];
}

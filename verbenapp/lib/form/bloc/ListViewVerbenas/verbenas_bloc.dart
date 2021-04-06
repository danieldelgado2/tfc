import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verbenapp/form/form.dart';

part 'verbenas_event.dart';
part 'verbenas_state.dart';

class VerbenasBloc extends Bloc<VerbenasEvent, VerbenasState> {
  VerbenasBloc() : super(VerbenasState.initial());

  @override
  Stream<VerbenasState> mapEventToState(
    VerbenasEvent event,
  ) async* {
    if (state.status == VerbenasStatus.initial) {
      yield VerbenasState.change([]);
    } else if (event is ChangeVerbenas) {
      yield VerbenasState.change(event.vbs);
    }
  }
}

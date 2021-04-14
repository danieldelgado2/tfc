import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'descarga_event.dart';
part 'descarga_state.dart';

class DescargaBloc extends Bloc<DescargaEvent, DescargaState> {
  DescargaBloc() : super(DescargaInitial());

  @override
  Stream<DescargaState> mapEventToState(
    DescargaEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}

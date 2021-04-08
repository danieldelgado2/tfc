import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banner_visible_event.dart';
part 'banner_visible_state.dart';

class BannerVisibleBloc extends Bloc<BannerVisibleEvent, BannerVisibleState> {
  BannerVisibleBloc() : super(BannerVisibleState.visible());

  @override
  Stream<BannerVisibleState> mapEventToState(
    BannerVisibleEvent event,
  ) async* {
    if (event.data)
      yield BannerVisibleState.visible();
    else
      yield BannerVisibleState.invisible();
  }
}

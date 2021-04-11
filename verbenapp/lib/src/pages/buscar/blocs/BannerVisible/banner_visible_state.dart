part of 'banner_visible_bloc.dart';

class BannerVisibleState {
  const BannerVisibleState._({this.visible = false});

  const BannerVisibleState.invisible() : this._();
  const BannerVisibleState.visible() : this._(visible: true);

  final visible;

  List<Object> get props => [visible];
}

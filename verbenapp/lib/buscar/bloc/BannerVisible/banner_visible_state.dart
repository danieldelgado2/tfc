part of 'banner_visible_bloc.dart';

class BannerVisibleState extends Equatable {
  const BannerVisibleState._({this.visible = false});

  const BannerVisibleState.invisible() : this._();
  const BannerVisibleState.visible() : this._(visible: true);

  final visible;
  @override
  List<Object> get props => [visible];
}
